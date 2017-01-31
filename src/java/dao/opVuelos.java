package dao;

import clases.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;

public class opVuelos {

    public opVuelos() {
    }

    public ArrayList<reserva> reservasCompletas(usuario usuario, Connection conexion) throws SQLException {
        ArrayList<reserva> reservas = new ArrayList();

        String sql = "select reservaOcupacion from ocupacion_back group by reservaOcupacion";
        PreparedStatement estado = conexion.prepareStatement(sql);
        ResultSet resultado = estado.executeQuery();

        ArrayList idsReserva = new ArrayList();
        while (resultado.next()) {
            idsReserva.add(resultado.getInt("reservaOcupacion"));
        }

        if (!idsReserva.isEmpty()) {
            String sql2 = "SELECT * FROM reserva_back WHERE idReserva = ? AND usuarioReserva = ?";
            for (int i = 0; i < idsReserva.size(); i++) {
                PreparedStatement estado2 = conexion.prepareStatement(sql2);
                estado2.setInt(1, (Integer) idsReserva.get(i));
                estado2.setInt(2, usuario.getId());
                ResultSet resultado2 = estado2.executeQuery();
                if (resultado2.next()) {
                    reserva reserva = new reserva();
                    reserva.setId(resultado2.getInt("idReserva"));
                    reserva.setCodigo(resultado2.getString("codReserva"));
                    if (resultado2.getInt("vueloidaReserva") != 0) {
                        reserva.setVueloida(new vuelo(resultado2.getInt("vueloidaReserva")));
                    }
                    if (resultado2.getInt("vuelovueltaReserva") != 0) {
                        reserva.setVuelovuelta(new vuelo(resultado2.getInt("vuelovueltaReserva")));
                    }
                    reserva.setFecha(resultado2.getTimestamp("fechaReserva").toLocalDateTime());
                    reserva.setNumpasajeros(resultado2.getInt("numviajerosReserva"));
                    reserva.setPrecio(resultado2.getInt("precioReserva"));
                    reservas.add(reserva);
                }
            }
        }
        return reservas;
    }

    public ArrayList<reserva> completarVuelos(ArrayList<reserva> reservas, Connection conexion) throws SQLException {
        for (reserva reserva : reservas) {
            if (reserva.getVueloida() != null) {

                //Busca los datos del vuelo
                String sql = "SELECT * FROM vuelo_back WHERE idVuelo = ?";
                PreparedStatement estado = conexion.prepareStatement(sql);
                estado.setInt(1, reserva.getVueloida().getId());
                ResultSet resultado = estado.executeQuery();
                resultado.next();
                reserva.getVueloida().setConexion(resultado.getInt("conexionVuelo"));
                reserva.getVueloida().setNumero(resultado.getString("numeroVuelo"));
                reserva.getVueloida().setFecha(LocalDate.parse(resultado.getString("fechavuelo")));
                reserva.getVueloida().setHoraSalida(LocalTime.parse(resultado.getString("horaSalidaVuelo")));
                reserva.getVueloida().setHoraLlegada(LocalTime.parse(resultado.getString("horaLlegadaVuelo")));
                reserva.getVueloida().setPrecio(resultado.getInt("precioVuelo"));

                //Busca los IATA de los aeropuertos y creando objetos aeropuerto
                sql = "SELECT * FROM conexion WHERE idConexion = ?";
                PreparedStatement estado2 = conexion.prepareStatement(sql);
                estado2.setInt(1, resultado.getInt("conexionVuelo"));
                ResultSet resultado2 = estado2.executeQuery();
                resultado2.next();
                aeropuerto aerorigen = new aeropuerto();
                aerorigen.setIata(resultado2.getString("origenConexion"));
                aeropuerto aerodestino = new aeropuerto();
                aerodestino.setIata(resultado2.getString("destinoConexion"));

                //Buscando los aeropuertos y añadiendolos al objeto vuelo
                //Origen
                sql = "SELECT * FROM aeropuerto WHERE iataAeropuerto LIKE ?";
                PreparedStatement estado3 = conexion.prepareStatement(sql);
                estado3.setString(1, aerorigen.getIata());
                ResultSet resultado3 = estado3.executeQuery();
                resultado3.next();

                aerorigen.setId(resultado3.getInt("idAeropuerto"));
                aerorigen.setCiudad(resultado3.getString("ciudadAeropuerto"));
                aerorigen.setPais(resultado3.getString("paisAeropuerto"));

                //Destino
                estado3.clearParameters();
                estado3.setString(1, aerodestino.getIata());
                resultado3 = estado3.executeQuery();
                resultado3.next();

                aerodestino.setId(resultado3.getInt("idAeropuerto"));
                aerodestino.setCiudad(resultado3.getString("ciudadAeropuerto"));
                aerodestino.setPais(resultado3.getString("paisAeropuerto"));

                reserva.getVueloida().setOrigen(aerorigen);
                reserva.getVueloida().setDestino(aerodestino);
            }
            //Comprobando si existe un vuelo de vuelta
            if (reserva.getVuelovuelta() != null) {
                //Busca los datos del vuelo
                String sql = "SELECT * FROM vuelo_back WHERE idVuelo = ?";
                PreparedStatement estado = conexion.prepareStatement(sql);
                estado.setInt(1, reserva.getVuelovuelta().getId());
                ResultSet resultado = estado.executeQuery();
                resultado.next();
                reserva.getVuelovuelta().setConexion(resultado.getInt("conexionVuelo"));
                reserva.getVuelovuelta().setNumero(resultado.getString("numeroVuelo"));
                reserva.getVuelovuelta().setFecha(LocalDate.parse(resultado.getString("fechavuelo")));
                reserva.getVuelovuelta().setHoraSalida(LocalTime.parse(resultado.getString("horaSalidaVuelo")));
                reserva.getVuelovuelta().setHoraLlegada(LocalTime.parse(resultado.getString("horaLlegadaVuelo")));
                reserva.getVuelovuelta().setPrecio(resultado.getInt("precioVuelo"));

                //Busca los IATA de los aeropuertos y creando objetos aeropuerto
                sql = "SELECT * FROM conexion WHERE idConexion = ?";
                PreparedStatement estado2 = conexion.prepareStatement(sql);
                estado2.setInt(1, resultado.getInt("conexionVuelo"));
                ResultSet resultado2 = estado2.executeQuery();
                resultado2.next();
                aeropuerto aerorigen = new aeropuerto();
                aerorigen.setIata(resultado2.getString("origenConexion"));
                aeropuerto aerodestino = new aeropuerto();
                aerodestino.setIata(resultado2.getString("destinoConexion"));

                //Buscando los aeropuertos y añadiendolos al objeto vuelo
                //Origen
                sql = "SELECT * FROM aeropuerto WHERE iataAeropuerto LIKE ?";
                PreparedStatement estado3 = conexion.prepareStatement(sql);
                estado3.setString(1, aerorigen.getIata());
                ResultSet resultado3 = estado3.executeQuery();
                resultado3.next();

                aerorigen.setId(resultado3.getInt("idAeropuerto"));
                aerorigen.setCiudad(resultado3.getString("ciudadAeropuerto"));
                aerorigen.setPais(resultado3.getString("paisAeropuerto"));

                //Destino
                estado3.clearParameters();
                estado3.setString(1, aerodestino.getIata());
                resultado3 = estado3.executeQuery();
                resultado3.next();

                aerodestino.setId(resultado3.getInt("idAeropuerto"));
                aerodestino.setCiudad(resultado3.getString("ciudadAeropuerto"));
                aerodestino.setPais(resultado3.getString("paisAeropuerto"));

                reserva.getVuelovuelta().setOrigen(aerorigen);
                reserva.getVuelovuelta().setDestino(aerodestino);
            }
        }

        return reservas;
    }

    public ArrayList<reserva> completarPasajeros(ArrayList<reserva> reservas, Connection conexion) throws SQLException {

        for (reserva reserva : reservas) {
            String sql = "SELECT pasajeroOcupacion FROM ocupacion_back WHERE reservaOcupacion = ? GROUP BY pasajeroOcupacion";
            PreparedStatement estado = conexion.prepareStatement(sql);
            estado.setInt(1, reserva.getId());
            ResultSet resultado = estado.executeQuery();
            while (resultado.next()) {
                try {
                    sql = "SELECT * FROM pasajero WHERE idPasajero = ?";
                    PreparedStatement estado2 = conexion.prepareStatement(sql);
                    estado2.setInt(1, resultado.getInt("pasajeroOcupacion"));
                    ResultSet resultado2 = estado2.executeQuery();
                    resultado2.next();

                    pasajero pasajero = new pasajero();
                    pasajero.setId(resultado2.getInt("idPasajero"));
                    pasajero.setNombre(resultado2.getString("nombrePasajero"));
                    pasajero.setApellidos(resultado2.getString("apellidosPasajero"));
                    pasajero.setPasaporte(resultado2.getString("pasaportePasajero"));
                    pasajero.setCadpasaporte(LocalDate.parse(resultado2.getString("cadpasaportePasajero")));
                    pasajero.setGenero(resultado2.getString("generoPasajero"));
                    pasajero.setEdad(resultado2.getString("edadPasajero"));
                    pasajero.setNacionalidad(resultado2.getString("nacionalidadPasajero"));
                    pasajero.setFechanac(LocalDate.parse(resultado2.getString("fechanacPasajero")));

                    //Obteniendo datos de ida de la tabla ocupacion
                    sql = "SELECT * FROM ocupacion_back WHERE reservaOcupacion = ? AND pasajeroOcupacion = ? AND tipoOcupacion LIKE ?";
                    PreparedStatement estado3 = conexion.prepareStatement(sql);
                    estado3.setInt(1, reserva.getId());
                    estado3.setInt(2, pasajero.getId());
                    estado3.setString(3, "ida");
                    ResultSet resultado3 = estado3.executeQuery();
                    if (resultado3.next()) {
                        pasajero.setAsientoida(resultado3.getInt("asientoOcupacion"));
                        pasajero.setTarjetaida(resultado3.getString("facturacionOcupacion"));
                        if (resultado3.getInt("bebeOcupacion") != 0) {
                            sql = "SELECT * FROM bebe WHERE idBebe = ?";
                            PreparedStatement estado4 = conexion.prepareStatement(sql);
                            estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                            ResultSet resultado4 = estado4.executeQuery();
                            resultado4.next();

                            pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                        }

                        //Obteniendo los servicios contratados
                        sql = "SELECT s.* FROM servicio s, servicioreserva_back sr WHERE sr.ocupacionRS = ? AND sr.servicioRS = s.idServicio";
                        PreparedStatement estado4 = conexion.prepareStatement(sql);
                        estado4.setInt(1, resultado3.getInt("idOcupacion"));
                        ResultSet resultado4 = estado4.executeQuery();
                        while (resultado4.next()) {
                            servicio servicio = new servicio();
                            servicio.setId(resultado4.getInt("idServicio"));
                            servicio.setNombre(resultado4.getString("nombreServicio"));
                            servicio.setDescripcion(resultado4.getString("descripcionServicio"));
                            servicio.setPrecio(resultado4.getInt("precioServicio"));

                            pasajero.getServiciosida().add(servicio);
                        }
                    }

                    //Obteniendo los datos de vuelta de la tabla ocupacion
                    if (reserva.getVuelovuelta() != null) {
                        estado3.setInt(1, reserva.getId());
                        estado3.setInt(2, pasajero.getId());
                        estado3.setString(3, "vuelta");
                        resultado3 = estado3.executeQuery();

                        if (resultado3.next()) {
                            pasajero.setAsientovuelta(resultado3.getInt("asientoOcupacion"));
                            pasajero.setTarjetavuelta(resultado3.getString("facturacionOcupacion"));
                            if (resultado3.getInt("bebeOcupacion") != 0) {
                                try {
                                    sql = "SELECT * FROM bebe WHERE idBebe = ?";
                                    PreparedStatement estado4 = conexion.prepareStatement(sql);
                                    estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                                    ResultSet resultado4 = estado4.executeQuery();
                                    resultado4.next();

                                    pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                                } catch (SQLException bebeback) {
                                    try {
                                        sql = "SELECT * FROM bebe_back WHERE idBebe = ?";
                                        PreparedStatement estado4 = conexion.prepareStatement(sql);
                                        estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                                        ResultSet resultado4 = estado4.executeQuery();
                                        resultado4.next();

                                        pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                                    } catch (SQLException er) {

                                    }
                                }
                            }

                            //Obteniendo los servicios contratados
                            sql = "SELECT s.* FROM servicio s, servicioreserva_back sr WHERE sr.ocupacionRS = ? AND sr.servicioRS = s.idServicio";
                            PreparedStatement estado4 = conexion.prepareStatement(sql);
                            estado4.setInt(1, resultado3.getInt("idOcupacion"));
                            ResultSet resultado4 = estado4.executeQuery();
                            while (resultado4.next()) {
                                servicio servicio = new servicio();
                                servicio.setId(resultado4.getInt("idServicio"));
                                servicio.setNombre(resultado4.getString("nombreServicio"));
                                servicio.setDescripcion(resultado4.getString("descripcionServicio"));
                                servicio.setPrecio(resultado4.getInt("precioServicio"));

                                pasajero.getServiciosvuelta().add(servicio);
                            }
                        }
                    }

                    reserva.añadirPasajero(pasajero);
                } catch (SQLException other) {
                    try {
                        sql = "SELECT * FROM pasajero_back WHERE idPasajero = ?";
                        PreparedStatement estado2 = conexion.prepareStatement(sql);
                        estado2.setInt(1, resultado.getInt("pasajeroOcupacion"));
                        ResultSet resultado2 = estado2.executeQuery();
                        resultado2.next();

                        pasajero pasajero = new pasajero();
                        pasajero.setId(resultado2.getInt("idPasajero"));
                        pasajero.setNombre(resultado2.getString("nombrePasajero"));
                        pasajero.setApellidos(resultado2.getString("apellidosPasajero"));
                        pasajero.setPasaporte(resultado2.getString("pasaportePasajero"));
                        pasajero.setCadpasaporte(LocalDate.parse(resultado2.getString("cadpasaportePasajero")));
                        pasajero.setGenero(resultado2.getString("generoPasajero"));
                        pasajero.setEdad(resultado2.getString("edadPasajero"));
                        pasajero.setNacionalidad(resultado2.getString("nacionalidadPasajero"));
                        pasajero.setFechanac(LocalDate.parse(resultado2.getString("fechanacPasajero")));

                        //Obteniendo datos de ida de la tabla ocupacion
                        sql = "SELECT * FROM ocupacion_back WHERE reservaOcupacion = ? AND pasajeroOcupacion = ? AND tipoOcupacion LIKE ?";
                        PreparedStatement estado3 = conexion.prepareStatement(sql);
                        estado3.setInt(1, reserva.getId());
                        estado3.setInt(2, pasajero.getId());
                        estado3.setString(3, "ida");
                        ResultSet resultado3 = estado3.executeQuery();
                        if (resultado3.next()) {
                            pasajero.setAsientoida(resultado3.getInt("asientoOcupacion"));
                            pasajero.setTarjetaida(resultado3.getString("facturacionOcupacion"));
                            if (resultado3.getInt("bebeOcupacion") != 0) {
                                try {
                                    sql = "SELECT * FROM bebe WHERE idBebe = ?";
                                    PreparedStatement estado4 = conexion.prepareStatement(sql);
                                    estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                                    ResultSet resultado4 = estado4.executeQuery();
                                    resultado4.next();

                                    pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                                } catch (SQLException bebeback) {
                                    try {
                                        sql = "SELECT * FROM bebe_back WHERE idBebe = ?";
                                        PreparedStatement estado4 = conexion.prepareStatement(sql);
                                        estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                                        ResultSet resultado4 = estado4.executeQuery();
                                        resultado4.next();

                                        pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                                    } catch (SQLException er) {

                                    }
                                }
                            }

                            //Obteniendo los servicios contratados
                            sql = "SELECT s.* FROM servicio s, servicioreserva_back sr WHERE sr.ocupacionRS = ? AND sr.servicioRS = s.idServicio";
                            PreparedStatement estado4 = conexion.prepareStatement(sql);
                            estado4.setInt(1, resultado3.getInt("idOcupacion"));
                            ResultSet resultado4 = estado4.executeQuery();
                            while (resultado4.next()) {
                                servicio servicio = new servicio();
                                servicio.setId(resultado4.getInt("idServicio"));
                                servicio.setNombre(resultado4.getString("nombreServicio"));
                                servicio.setDescripcion(resultado4.getString("descripcionServicio"));
                                servicio.setPrecio(resultado4.getInt("precioServicio"));

                                pasajero.getServiciosida().add(servicio);
                            }
                        }

                        //Obteniendo los datos de vuelta de la tabla ocupacion
                        if (reserva.getVuelovuelta() != null) {
                            estado3.setInt(1, reserva.getId());
                            estado3.setInt(2, pasajero.getId());
                            estado3.setString(3, "vuelta");
                            resultado3 = estado3.executeQuery();

                            if (resultado3.next()) {
                                pasajero.setAsientovuelta(resultado3.getInt("asientoOcupacion"));
                                pasajero.setTarjetavuelta(resultado3.getString("facturacionOcupacion"));
                                if (resultado3.getInt("bebeOcupacion") != 0) {
                                    sql = "SELECT * FROM bebe_back WHERE idBebe = ?";
                                    PreparedStatement estado4 = conexion.prepareStatement(sql);
                                    estado4.setInt(1, resultado3.getInt("bebeOcupacion"));
                                    ResultSet resultado4 = estado4.executeQuery();
                                    resultado4.next();

                                    pasajero.setBebe(new bebe(resultado4.getInt("idBebe"), resultado4.getString("nombreBebe"), resultado4.getString("apellidosBebe"), resultado4.getString("dniBebe")));
                                }

                                //Obteniendo los servicios contratados
                                sql = "SELECT s.* FROM servicio s, servicioreserva_back sr WHERE sr.ocupacionRS = ? AND sr.servicioRS = s.idServicio";
                                PreparedStatement estado4 = conexion.prepareStatement(sql);
                                estado4.setInt(1, resultado3.getInt("idOcupacion"));
                                ResultSet resultado4 = estado4.executeQuery();
                                while (resultado4.next()) {
                                    servicio servicio = new servicio();
                                    servicio.setId(resultado4.getInt("idServicio"));
                                    servicio.setNombre(resultado4.getString("nombreServicio"));
                                    servicio.setDescripcion(resultado4.getString("descripcionServicio"));
                                    servicio.setPrecio(resultado4.getInt("precioServicio"));

                                    pasajero.getServiciosvuelta().add(servicio);
                                }
                            }
                        }

                        reserva.añadirPasajero(pasajero);
                    } catch (SQLException er) {

                    }
                }

            }
        }

        return reservas;
    }
}
