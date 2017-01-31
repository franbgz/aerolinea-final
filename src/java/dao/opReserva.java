package dao;

import java.time.LocalDate;
import clases.vuelo;
import clases.aeropuerto;
import clases.servicio;
import clases.usuario;
import clases.pagador;
import clases.bebe;
import clases.tarjeta;
import clases.reserva;
import clases.pasajero;
import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;

public class opReserva {

    public opReserva() {
    }

    public aeropuerto buscarAeropuerto(aeropuerto aeropuerto, Connection conexion) throws SQLException {
        String ciudad = aeropuerto.getCiudad();
        String sql = "SELECT * FROM aeropuerto WHERE ciudadAeropuerto LIKE ?";
        PreparedStatement estado = conexion.prepareStatement(sql);
        estado.setString(1, ciudad);

        ResultSet resultado = estado.executeQuery();
        resultado.next();

        aeropuerto = new aeropuerto(resultado.getInt("idAeropuerto"), resultado.getString("iataAeropuerto"), resultado.getString("ciudadAeropuerto"), resultado.getString("paisAeropuerto"));
        return aeropuerto;
    }

    public ArrayList<vuelo> buscarVuelo(aeropuerto aerorigen, aeropuerto aerodestino, LocalDate fecha, Connection conexion) throws SQLException {
        String origen = aerorigen.getCiudad();
        String destino = aerodestino.getCiudad();

        //Buscando el ID de la conexion entre origen y destino
        String sql = "SELECT idConexion FROM conexion WHERE origenConexion LIKE (SELECT iataAeropuerto FROM aeropuerto WHERE ciudadAeropuerto LIKE ?) AND destinoConexion LIKE (SELECT iataAeropuerto FROM aeropuerto WHERE ciudadAeropuerto LIKE ?)";
        PreparedStatement estado1 = conexion.prepareStatement(sql);
        estado1.setString(1, origen);
        estado1.setString(2, destino);

        ResultSet resultado = estado1.executeQuery();
        resultado.next();
        int idConexion = resultado.getInt("idConexion");

        //Buscando vuelos y ordenandolos por cercania
        String sql2 = "SELECT *, ABS(DATEDIFF(vuelo.fechaVuelo, ?)) AS diferencia FROM vuelo where conexionVuelo = ? and disponiblesVuelo <> 0 ORDER BY diferencia";
        PreparedStatement estado2 = conexion.prepareStatement(sql2);
        estado2.setString(1, fecha.toString());
        estado2.setInt(2, idConexion);
        ResultSet resultado2 = estado2.executeQuery();

        //Sacando los datos del ResultSet, y creando objetos de tipo vuelo para añadirlos en el arraylist
        ArrayList<vuelo> vuelos = new ArrayList();
        while (resultado2.next()) {
            vuelo vuelo = new vuelo();
            vuelo.setId(resultado2.getInt("idVuelo"));
            vuelo.setConexion(resultado2.getInt("conexionVuelo"));
            vuelo.setNumero(resultado2.getString("numeroVuelo"));
            vuelo.setFecha(LocalDate.parse(resultado2.getString("fechaVuelo")));
            vuelo.setHoraSalida(LocalTime.parse(resultado2.getString("horaSalidaVuelo")));
            vuelo.setHoraLlegada(LocalTime.parse(resultado2.getString("horaLlegadaVuelo")));
            vuelo.setDisponible(resultado2.getInt("disponiblesVuelo"));
            vuelo.setPrecio(resultado2.getInt("precioVuelo"));

            vuelos.add(vuelo);
        }

        estado1.close();
        estado2.close();
        return vuelos;
    }

    public ArrayList<servicio> buscarServicios(Connection conexion) throws SQLException {
        String sql = "SELECT * FROM servicio";
        PreparedStatement estado = conexion.prepareStatement(sql);
        ResultSet resultado = estado.executeQuery();

        ArrayList<servicio> servicios = new ArrayList();
        while (resultado.next()) {
            servicio servicio = new servicio();
            servicio.setId(resultado.getInt("idServicio"));
            servicio.setNombre(resultado.getString("nombreServicio"));
            servicio.setDescripcion(resultado.getString("descripcionServicio"));
            servicio.setPrecio(resultado.getInt("precioServicio"));
            servicios.add(servicio);
        }

        return servicios;
    }

    public boolean[] asientosOcupados(vuelo vuelo, Connection conexion) throws SQLException {
        //Buscando en ocupacion cuando el vuelo es de ida
        String sql = "SELECT o.asientoOcupacion, r.vueloidaReserva, o.tipoOcupacion FROM reserva r, ocupacion o WHERE r.idReserva = o.reservaOcupacion HAVING o.tipoOcupacion LIKE 'ida' AND r.vueloidaReserva = ?";
        PreparedStatement estado = conexion.prepareStatement(sql);
        estado.setInt(1, vuelo.getId());
        ResultSet resultado = estado.executeQuery();

        ArrayList<Integer> arrayOcupados = new ArrayList();
        while (resultado.next()) {
            arrayOcupados.add(resultado.getInt("asientoOcupacion"));
        }

        boolean[] asientoslibres = new boolean[8];
        Arrays.fill(asientoslibres, Boolean.TRUE);
        for (int i = 0; i < arrayOcupados.size(); i++) {
            asientoslibres[arrayOcupados.get(i) - 1] = false;
        }

        //Buscando en ocupacion cuando el vuelo es de vuelta
        sql = "SELECT o.asientoOcupacion, r.vuelovueltaReserva, o.tipoOcupacion FROM reserva r, ocupacion o WHERE r.idReserva = o.reservaOcupacion HAVING o.tipoOcupacion LIKE 'vuelta' AND r.vuelovueltaReserva = ?";
        PreparedStatement estado2 = conexion.prepareStatement(sql);
        estado2.setInt(1, vuelo.getId());
        resultado = estado2.executeQuery();
        arrayOcupados.clear();
        while (resultado.next()) {
            arrayOcupados.add(resultado.getInt("asientoOcupacion"));
        }
        for (int i = 0; i < arrayOcupados.size(); i++) {
            asientoslibres[arrayOcupados.get(i) - 1] = false;
        }

        return asientoslibres;
    }

    public int registrarUsuario(usuario usuario, Connection conexion) throws SQLException {
        String sql = "INSERT INTO usuario (emailUsuario, passUsuario, nombreUsuario, apellidosUsuario, telefonoUsuario, fechanacUsuario) VALUES (?, ?, ? , ?, ?, ?)";
        PreparedStatement estado = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        estado.setString(1, usuario.getEmail());
        estado.setString(2, usuario.getPass());
        estado.setString(3, usuario.getNombre());
        estado.setString(4, usuario.getApellidos());
        estado.setString(5, usuario.getTelefono());
        estado.setString(6, usuario.getFechanac().toString());

        estado.executeUpdate();
        ResultSet resultado = estado.getGeneratedKeys();
        resultado.next();
        return resultado.getInt(1);
    }

    public usuario verificarUsuario(usuario usuario, Connection conexion) throws SQLException {
        String sql = "SELECT * FROM usuario WHERE emailUsuario = ? AND passUsuario = ?";
        PreparedStatement estado = conexion.prepareStatement(sql);
        estado.setString(1, usuario.getEmail());
        estado.setString(2, usuario.getPass());

        ResultSet resultado = estado.executeQuery();

        if (resultado.next()) {
            usuario.setId(resultado.getInt("idUsuario"));
            usuario.setEmail(resultado.getString("emailUsuario"));
            usuario.setPass(resultado.getString("passUsuario"));
            usuario.setNombre(resultado.getString("nombreUsuario"));
            usuario.setApellidos(resultado.getString("apellidosUsuario"));
            usuario.setTelefono(resultado.getString("telefonoUsuario"));
            usuario.setFechanac(LocalDate.parse(resultado.getString("fechanacUsuario")));
            return usuario;
        } else {
            usuario = null;
            return usuario;
        }
    }

    public ArrayList<pagador> buscarPagadores(usuario usuario, Connection conexion) throws SQLException {
        int idUsuario = usuario.getId();

        String sql = "SELECT * FROM pagador WHERE usuarioPagador = ?";
        PreparedStatement estado = conexion.prepareStatement(sql);
        estado.setInt(1, idUsuario);
        ResultSet resultado = estado.executeQuery();

        ArrayList<pagador> pagadores = new ArrayList();
        while (resultado.next()) {
            pagador pagador = new pagador();
            pagador.setId(resultado.getInt("idPagador"));
            pagador.setNombre(resultado.getString("nombrePagador"));
            pagador.setApellidos(resultado.getString("apellidosPagador"));
            pagador.setDni(resultado.getString("dniPagador"));
            pagador.setDireccion(resultado.getString("direccionPagador"));
            pagador.setPoblacion(resultado.getString("poblacionPagador"));
            pagadores.add(pagador);
        }

        return pagadores;
    }

    public ArrayList<tarjeta> buscarTarjetas(usuario usuario, Connection conexion) throws SQLException {
        int idUsuario = usuario.getId();

        String sql = "SELECT * FROM tarjeta WHERE usuarioTarjeta = ? ORDER BY usosTarjeta DESC";
        PreparedStatement estado = conexion.prepareStatement(sql);
        estado.setInt(1, idUsuario);
        ResultSet resultado = estado.executeQuery();

        ArrayList<tarjeta> tarjetas = new ArrayList();
        while (resultado.next()) {
            tarjeta tarjeta = new tarjeta();
            tarjeta.setId(resultado.getInt("idTarjeta"));
            tarjeta.setNumero(resultado.getString("numeroTarjeta"));
            tarjeta.setPropietario(resultado.getString("propietarioTarjeta"));
            tarjeta.setCaducidad(LocalDate.parse(resultado.getString("caducidadTarjeta")));
            tarjeta.setCodseguridad(resultado.getString("codseguridadTarjeta"));
            tarjeta.setUsos(resultado.getInt("usosTarjeta"));
            tarjetas.add(tarjeta);
        }

        return tarjetas;
    }

    public boolean grabarReserva(reserva reserva, Connection conexion) {
        try {
            String sql;
            conexion.setAutoCommit(false);

            //Insercion o actualizacion de tarjeta
            tarjeta tarjeta = reserva.getTarjeta();
            if (tarjeta.getId() == null) {
                sql = "INSERT INTO tarjeta (usuarioTarjeta, numeroTarjeta, propietarioTarjeta, caducidadTarjeta, codseguridadTarjeta) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement estado1 = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                estado1.setInt(1, reserva.getUsuario().getId());
                estado1.setString(2, tarjeta.getNumero());
                estado1.setString(3, tarjeta.getPropietario());
                estado1.setString(4, tarjeta.getCaducidad().toString());
                estado1.setString(5, tarjeta.getCodseguridad());

                if (estado1.executeUpdate() == 1) {
                    ResultSet claves = estado1.getGeneratedKeys();
                    claves.next();
                    reserva.getTarjeta().setId(claves.getInt(1));
                    estado1.close();
                } else {
                    estado1.close();
                    throw new SQLException();
                }
            } else {
                sql = "UPDATE tarjeta SET usosTarjeta = usosTarjeta + 1 WHERE idTarjeta = ?";
                PreparedStatement estado = conexion.prepareStatement(sql);
                estado.setInt(1, tarjeta.getId());
                if (estado.executeUpdate() != 1) {
                    estado.close();
                    conexion.rollback();
                    throw new SQLException();
                } else {
                    estado.close();
                }

            }

            //Insercion o actualizacion de pagador
            pagador pagador = reserva.getPagador();
            if (pagador.getId() == null) {
                sql = "INSERT INTO pagador (dniPagador, nombrePagador, apellidosPagador, direccionPagador, poblacionPagador, usuarioPagador) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement estado = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                estado.setString(1, pagador.getDni());
                estado.setString(2, pagador.getNombre());
                estado.setString(3, pagador.getApellidos());
                estado.setString(4, pagador.getDireccion());
                estado.setString(5, pagador.getPoblacion());
                estado.setInt(6, reserva.getUsuario().getId());

                if (estado.executeUpdate() == 1) {
                    ResultSet claves = estado.getGeneratedKeys();
                    claves.next();
                    reserva.getPagador().setId(claves.getInt(1));
                    estado.close();
                } else {
                    estado.close();
                    conexion.rollback();
                    throw new SQLException();
                }

            }

            //Insercion de pasajeros
            for (int i = 0; i < reserva.getNumpasajeros(); i++) {
                pasajero pasajero = reserva.getPasajero(i);
                sql = "SELECT idPasajero FROM pasajero WHERE pasaportePasajero = ?";
                PreparedStatement estado1 = conexion.prepareStatement(sql);
                estado1.setString(1, pasajero.getPasaporte());
                ResultSet resultado = estado1.executeQuery();
                if (resultado.next()) {
                    reserva.getPasajero(i).setId(resultado.getInt("idPasajero"));
                    sql = "UPDATE pasajero SET cadpasaportePasajero = ? WHERE idPasajero = ?";
                    PreparedStatement estadocad = conexion.prepareStatement(sql);
                    estadocad.setString(1, pasajero.getCadpasaporte().toString());
                    estadocad.setInt(2, pasajero.getId());
                }
                estado1.close();

                if (reserva.getPasajero(i).getId() == null) {
                    sql = "INSERT INTO pasajero (nombrePasajero, apellidosPasajero, pasaportePasajero, cadpasaportePasajero, generoPasajero, edadPasajero, nacionalidadPasajero, fechanacPasajero) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement estado = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    estado.setString(1, pasajero.getNombre());
                    estado.setString(2, pasajero.getApellidos());
                    estado.setString(3, pasajero.getPasaporte());
                    estado.setString(4, pasajero.getCadpasaporte().toString());
                    estado.setString(5, pasajero.getGenero());
                    estado.setString(6, pasajero.getEdad());
                    estado.setString(7, pasajero.getNacionalidad());
                    estado.setString(8, pasajero.getFechanac().toString());

                    if (estado.executeUpdate() == 1) {
                        ResultSet claves = estado.getGeneratedKeys();
                        claves.next();
                        pasajero.setId(claves.getInt(1));
                        estado.close();
                    } else {
                        estado.close();
                    }
                }

            }

            //Inserccion de bebes
            for (int i = 0; i < reserva.getNumpasajeros(); i++) {
                pasajero pasajero = reserva.getPasajero(i);
                bebe bebe = pasajero.getBebe();
                if (bebe != null) {
                    sql = "SELECT idBebe FROM bebe WHERE dniBebe = ?";
                    PreparedStatement estado1 = conexion.prepareStatement(sql);
                    estado1.setString(1, bebe.getDni());
                    ResultSet resultado = estado1.executeQuery();
                    if (resultado.next()) {
                        reserva.getPasajero(i).getBebe().setId(resultado.getInt("idBebe"));
                    } else {
                        sql = "INSERT INTO bebe (nombreBebe, apellidosBebe, dniBebe) VALUES (?, ?, ?)";
                        PreparedStatement estado2 = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                        estado2.setString(1, bebe.getNombre());
                        estado2.setString(2, bebe.getApellidos());
                        estado2.setString(3, bebe.getDni());

                        if (estado2.executeUpdate() == 1) {
                            ResultSet claves = estado2.getGeneratedKeys();
                            claves.next();
                            bebe.setId(claves.getInt(1));
                        }
                        estado2.close();
                    }
                    estado1.close();
                }
            }

            //Insercion de reserva
            sql = "INSERT INTO reserva (vueloidaReserva, vuelovueltaReserva, codReserva, pagadorReserva, tarjetaReserva, numviajerosReserva, usuarioReserva, precioReserva) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement estadoReserva = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            estadoReserva.setInt(1, reserva.getVueloida().getId());
            if (reserva.getVuelovuelta() != null) {
                estadoReserva.setInt(2, reserva.getVuelovuelta().getId());
            } else {
                estadoReserva.setNull(2, 0);
            }
            estadoReserva.setString(3, reserva.getCodigo());
            estadoReserva.setInt(4, reserva.getPagador().getId());
            estadoReserva.setInt(5, reserva.getTarjeta().getId());
            estadoReserva.setInt(6, reserva.getNumpasajeros());
            estadoReserva.setInt(7, reserva.getUsuario().getId());
            estadoReserva.setInt(8, reserva.getPrecio());
            if (estadoReserva.executeUpdate() == 1) {
                ResultSet claves = estadoReserva.getGeneratedKeys();
                claves.next();
                reserva.setId(claves.getInt(1));
            }
            estadoReserva.close();

            //Insercion ocupacion
            ArrayList idOcupacionIda = new ArrayList();
            ArrayList idOcupacionVuelta = new ArrayList();
            for (int i = 0; i < reserva.getNumpasajeros(); i++) {
                pasajero pasajero = reserva.getPasajero(i);
                sql = "INSERT INTO ocupacion (reservaOcupacion, pasajeroOcupacion, bebeOcupacion, tipoOcupacion, asientoOcupacion) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement estado = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                estado.setInt(1, reserva.getId());
                estado.setInt(2, pasajero.getId());
                if (pasajero.getBebe() != null) {
                    estado.setInt(3, pasajero.getBebe().getId());
                } else {
                    estado.setNull(3, 0);
                }
                estado.setString(4, "ida");
                estado.setInt(5, pasajero.getAsientoida());

                if (estado.executeUpdate() == 1) {
                    ResultSet claves = estado.getGeneratedKeys();
                    claves.next();
                    int idOcupacion = claves.getInt(1);
                    for (servicio servicio : pasajero.getServiciosida()) {
                        sql = "INSERT INTO servicioreserva (ocupacionRS, servicioRS) VALUES (?, ?)";
                        PreparedStatement estado2 = conexion.prepareStatement(sql);
                        estado2.setInt(1, idOcupacion);
                        estado2.setInt(2, servicio.getId());
                        estado2.executeUpdate();
                        estado2.close();
                    }
                }
                estado.close();
            }
            if (reserva.getVuelovuelta() != null) {
                for (int i = 0; i < reserva.getNumpasajeros(); i++) {
                    pasajero pasajero = reserva.getPasajero(i);
                    sql = "INSERT INTO ocupacion (reservaOcupacion, pasajeroOcupacion, bebeOcupacion, tipoOcupacion, asientoOcupacion) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement estado = conexion.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    estado.setInt(1, reserva.getId());
                    estado.setInt(2, pasajero.getId());
                    if (pasajero.getBebe() != null) {
                        estado.setInt(3, pasajero.getBebe().getId());
                    } else {
                        estado.setNull(3, 0);
                    }
                    estado.setString(4, "vuelta");
                    estado.setInt(5, pasajero.getAsientovuelta());

                    if (estado.executeUpdate() == 1) {
                        ResultSet claves = estado.getGeneratedKeys();
                        claves.next();
                        int idOcupacion = claves.getInt(1);
                        for (servicio servicio : pasajero.getServiciosvuelta()) {
                            sql = "INSERT INTO servicioreserva (ocupacionRS, servicioRS) VALUES (?, ?)";
                            PreparedStatement estado2 = conexion.prepareStatement(sql);
                            estado2.setInt(1, idOcupacion);
                            estado2.setInt(2, servicio.getId());
                            estado2.executeUpdate();
                            estado2.close();
                        }
                    }
                    estado.close();
                }
            }

            //Actualizar la disponibilidad en vuelo
            sql = "UPDATE vuelo SET disponiblesVuelo = disponiblesVuelo - ? WHERE idVuelo = ?";
            PreparedStatement estadoVuelo = conexion.prepareStatement(sql);
            estadoVuelo.setInt(1, reserva.getNumpasajeros());
            estadoVuelo.setInt(2, reserva.getVueloida().getId());
            if (estadoVuelo.executeUpdate() != 1) {
                estadoVuelo.close();
                throw new SQLException();
            }
            if (reserva.getVuelovuelta() != null) {
                try (PreparedStatement estadoVuelo2 = conexion.prepareStatement(sql)) {
                    estadoVuelo2.setInt(1, reserva.getNumpasajeros());
                    estadoVuelo2.setInt(2, reserva.getVuelovuelta().getId());
                    if (estadoVuelo2.executeUpdate() != 1) {
                        estadoVuelo2.close();
                        throw new SQLException();
                    }
                }
            }
            estadoVuelo.close();

            conexion.commit();
            conexion.setAutoCommit(true);
            return true;
        } catch (SQLException er) {
            String msg = er.getMessage();
            int cod = er.getErrorCode();
            return false;
        }

    }
}
