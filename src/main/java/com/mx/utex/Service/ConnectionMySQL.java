package com.mx.utex.Service;

import java.sql.*;

public class ConnectionMySQL {
    public static Connection getConnection() throws SQLException {
        String host = "127.0.0.1";//172.31.44.34//54.173.40.143//127.0.0.1//localhost
        String port = "3306";
        String database = "productoselectronicos";
        String useSSL = "false";
        String timezone = "UTC";
        String url = String.format("jdbc:mysql://%s:%s/%s?allowPublicKeyRetrieval=true&useSSL=%s&serverTimezone=%s", host, port, database, useSSL, timezone);//allowPublicKeyRetrieval=true&
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
        return DriverManager.getConnection(url,"root","");//Integr4dor@
     /*   try {

           System.out.println("Conectado");
       }catch(Exception e){
           System.out.println("No Conectado");
        }*/

    }

    public static void closeConnections(Connection con, CallableStatement cstm, ResultSet rs){
        try{
            if(rs != null){ rs.close(); }

            if(cstm != null){ cstm.close(); }

            if(con != null){ con.close(); }

        }catch(SQLException e){ }
    }

    public static void closeConnections(Connection con, CallableStatement cstm) {
        try {
            if (cstm != null) {
                cstm.close();
            }

            if (con != null) {
                con.close();
            }

        } catch (SQLException e) {
        }
    }
}
