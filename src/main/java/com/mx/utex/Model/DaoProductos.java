package com.mx.utex.Model;

import com.mx.utex.Model.BeanProducto;
import com.mx.utex.Model.BeanDatos;
import com.mx.utex.Service.ConnectionMySQL;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class DaoProductos {
Connection con;
CallableStatement cstm;
ResultSet rs;
Logger logger = LoggerFactory.getLogger(DaoProductos.class);
int r;


public List<BeanProducto> findAll(){
    List<BeanProducto> listProductos = new ArrayList<>();

    try{
        con = ConnectionMySQL.getConnection();
        cstm = con.prepareCall("select *from productos as p inner join direcciones as d on p.Idfabricante = d.Iddireccion");
        rs = cstm.executeQuery();

        while(rs.next()) {
            BeanProducto producto = new BeanProducto();
            BeanDatos datos = new BeanDatos();

            producto.setIdproducto(rs.getInt("idproducto"));
            producto.setNombre(rs.getString("Nombre"));
            producto.setFecharegistro(rs.getString("Fecharegistro"));
            producto.setStatus(rs.getInt("Status"));

            datos.setIddireccion(rs.getInt("Iddireccion"));
            datos.setCalle(rs.getString("Calle"));
            datos.setColonia(rs.getString("Colonia"));
            datos.setCodigopostal(rs.getInt("CodigoPostal"));
            datos.setEstado(rs.getString("Estado"));
            datos.setPais(rs.getString("Pais"));

            producto.setIdfabricante(datos);

        listProductos.add(producto);
        }
    }catch(SQLException e){
        logger.error("Ha ocurrido un error: " + e.getMessage());
    }finally {
        ConnectionMySQL.closeConnections(con,cstm,rs);
    }
return listProductos;
}

    public BeanProducto finbyid(int id){
        BeanProducto producto = null;
        try{
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("select *from productos as p inner join direcciones as d on p.Idfabricante = d.Iddireccion where p.idproducto = ?");
            cstm.setInt(1,id);
            rs = cstm.executeQuery();

            if(rs.next()) {
               producto = new BeanProducto();
                BeanDatos datos = new BeanDatos();

                producto.setIdproducto(rs.getInt("idproducto"));
                producto.setNombre(rs.getString("Nombre"));
                producto.setFecharegistro(rs.getString("Fecharegistro"));
                producto.setStatus(rs.getInt("Status"));

                datos.setIddireccion(rs.getInt("Iddireccion"));
                datos.setCalle(rs.getString("Calle"));
                datos.setColonia(rs.getString("Colonia"));
                datos.setCodigopostal(rs.getInt("CodigoPostal"));
                datos.setEstado(rs.getString("Estado"));
                datos.setPais(rs.getString("Pais"));

                producto.setIdfabricante(datos);
            }
        }catch(SQLException e){
            logger.error("Ha ocurrido un error: " + e.getMessage());
        }finally {
            ConnectionMySQL.closeConnections(con,cstm,rs);
        }
        return producto;
    }

public int agregar(BeanProducto producto){
    try{
    con = ConnectionMySQL.getConnection();
    cstm = con.prepareCall("{call registerproduct(?,?,?,?,?,?,?)}");


    cstm.setString(1,producto.getNombre());
    cstm.setString(2,producto.getFecharegistro());
    cstm.setString(3,producto.getIdfabricante().getCalle());
    cstm.setString(4,producto.getIdfabricante().getColonia());
    cstm.setInt(5,producto.getIdfabricante().getCodigopostal());
    cstm.setString(6,producto.getIdfabricante().getEstado());
    cstm.setString(7,producto.getIdfabricante().getPais());

    cstm.executeUpdate();
    }catch(SQLException e){
        logger.error("Ha ocurrido un error: " + e.getMessage());
    }finally {
        ConnectionMySQL.closeConnections(con,cstm);
    }
    return r;
}


    public int modificar(BeanProducto producto){
        try{
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call modifyproduct(?,?,?,?,?,?,?,?)}");

            cstm.setInt(1,producto.getIdproducto());
            cstm.setString(2,producto.getNombre());
            cstm.setString(3,producto.getFecharegistro());
            cstm.setString(4,producto.getIdfabricante().getCalle());
            cstm.setString(5,producto.getIdfabricante().getColonia());
            cstm.setInt(6,producto.getIdfabricante().getCodigopostal());
            cstm.setString(7,producto.getIdfabricante().getEstado());
            cstm.setString(8,producto.getIdfabricante().getPais());

            cstm.executeUpdate();
        }catch(SQLException e){
            logger.error("Ha ocurrido un error: " + e.getMessage());
        }finally {
            ConnectionMySQL.closeConnections(con,cstm);
        }
        return r;
    }

    public void eliminar(int idproducto){
    try{
        con = ConnectionMySQL.getConnection();
        cstm = con.prepareCall("{call deleteproduct(?)}");
        cstm.setInt(1,idproducto);
        cstm.executeUpdate();
    }catch (SQLException e){
        logger.error("Ha ocurrido un error: " + e.getMessage());
    }finally {
        ConnectionMySQL.closeConnections(con,cstm);
    }
    }

    public void eliminartemporal(int id){
        try{
            con = ConnectionMySQL.getConnection();
            cstm = con.prepareCall("{call deletetemporalprod(?)}");
            cstm.setInt(1,id);
            cstm.executeUpdate();
        }catch(SQLException e){
            logger.error("Ha ocurrido un error: " + e.getMessage());
        }finally {
            ConnectionMySQL.closeConnections(con,cstm);
        }
    }




}
