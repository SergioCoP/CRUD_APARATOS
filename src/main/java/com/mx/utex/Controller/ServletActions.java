package com.mx.utex.Controller;

import com.mx.utex.Model.BeanProducto;
import com.mx.utex.Model.BeanDatos;
import com.mx.utex.Model.DaoProductos;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "ServletActions", value = "/ServletActions")
public class ServletActions extends HttpServlet {
    private Map map = new HashMap();
    BeanProducto producto = new BeanProducto();
    BeanDatos datos = new BeanDatos();
    DaoProductos daoproducto = new DaoProductos();


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        switch (action) {
            case "Listar":
                List<BeanProducto> listProductos = new DaoProductos().findAll();
                map.put("ListProductos", listProductos);
                write(response, map);
                map.clear();
                return;
            case "BuscarProductoporid":
                int id = Integer.parseInt(request.getParameter("idproducto"));
                map.put("Producto", new DaoProductos().finbyid(id));
                write(response,map);
                map.clear();
                return;
            case "Registrar":
                String nombre = request.getParameter("txtnombre");
                String fechareg = request.getParameter("txtfechareg");
                String calle = request.getParameter("txtcalle");
                String colonia = request.getParameter("txtcolonia");
                int codigopostal = Integer.parseInt(request.getParameter("txtcodigopostal"));
                String estado = request.getParameter("txtestado");
                String pais = request.getParameter("txtpais");

                producto.setNombre(nombre);
                producto.setFecharegistro(fechareg);

                datos.setCalle(calle);
                datos.setColonia(colonia);
                datos.setCodigopostal(codigopostal);
                datos.setEstado(estado);
                datos.setPais(pais);

                producto.setIdfabricante(datos);

                daoproducto.agregar(producto);
                break;
            case "Modificar":
                int idprod = Integer.parseInt(request.getParameter("txtidproducto"));
                String nombre1 =  request.getParameter("nombre");
                String fechareg1 = request.getParameter("fechareg");
                String calle1 = request.getParameter("calle");
                String colonia1 = request.getParameter("colonia");
                int codigopostal1 = Integer.parseInt(request.getParameter("codigopos"));
                String estado1 = request.getParameter("estado");
                String pais1 = request.getParameter("pais");

                producto.setIdproducto(idprod);
                producto.setNombre(nombre1);
                producto.setFecharegistro(fechareg1);

                datos.setCalle(calle1);
                datos.setColonia(colonia1);
                datos.setCodigopostal(codigopostal1);
                datos.setEstado(estado1);
                datos.setPais(pais1);

                producto.setIdfabricante(datos);

                daoproducto.modificar(producto);
                request.getRequestDispatcher("/views/index.jsp").forward(request, response);
                break;
            case "Eliminar":
                int idprod1 = Integer.parseInt(request.getParameter("txtidproducto"));
                daoproducto = new DaoProductos();
                daoproducto.eliminar(idprod1);
                request.getRequestDispatcher("/views/index.jsp").forward(request, response);
                break;
            case "BajaTemporal":
                int idprod2 = Integer.parseInt(request.getParameter("txtidproducto"));
                daoproducto = new DaoProductos();
                daoproducto.eliminartemporal(idprod2);
                request.getRequestDispatcher("/views/index.jsp").forward(request, response);
                break;
        }
    }

        /**
         * Handles the HTTP <code>GET</code> method.
         *
         * @param request servlet request
         * @param response servlet response
         * @throws ServletException if a servlet-specific error occurs
         * @throws IOException if an I/O error occurs
         */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            processRequest(request,response);
        }


    private void write(HttpServletResponse response, Map<String, Object> map) throws IOException {
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(map));
    }
}
