<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<html>
<head>
    <link rel="stylesheet" href="${context}/assets/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${context}/assets/dist/css/main.css">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
    <title>INICIO | CRUD</title>
</head>
<body>

<nav class="navbar navbar-dark bg-dark ">
    <button type="button" class="btn btn-success" data-bs-target="#Modalregistro" data-bs-toggle="modal" id="btn-registrar">Registrar</button>
    <div class="align-content-center">
        <h4>CRUD - Listado y Registro "Asíncrona" || Modificar, Eliminar y Información "Síncrona"</h4>
    </div>


</nav>
<table class="table table-dark">
    <thead class="">
    <tr>
        <th>#</th>
        <th>Producto</th>
        <th>Dirección</th>
        <th>Pais</th>
        <th>Estado</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody id="Cont_productos">
    </tbody>
</table>



<!--Modales-->
<div class="modal fade" id="Modalregistro" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content col-sm-12">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Registro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="row g-3" id="frmregistrar" method="POST" action="/ServletActions?action=Registrar" >
                    <div class="col-sm-7">
                        <label for="txtproducto" class="col-form-label">Producto:</label>
                        <input type="text" class="form-control" id="txtproducto">
                    </div>
                    <div class="col-sm-5">
                        <label for="txtfecha" class="col-form-label">Fecha Registro:</label>
                        <input type="date" class="form-control" id="txtfecha">
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcalle" class="col-form-label">Calle:</label>
                        <input type="text" class="form-control" id="txtcalle">
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcolonia" class="col-form-label">Colonia:</label>
                        <input type="text" class="form-control" id="txtcolonia">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtcodigopostal" class="col-form-label">Codigo Postal:</label>
                        <input type="text" class="form-control" id="txtcodigopostal">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtestado" class="col-form-label">Estado:</label>
                        <input type="text" class="form-control" id="txtestado">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtpais" class="col-form-label">Pais:</label>
                        <input type="text" class="form-control" id="txtpais">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-success" id="btn-guardar">Guardar</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="Modalmodificar" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content col-sm-12">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel1">Modificar</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="row g-3" id="frmModificar" method="POST" action="${context}/ServletActions">
                    <input type="hidden" name="action" value="Modificar">
                    <input type="hidden" name="txtidproducto" id="txtidprod" value="">
                    <div class="col-sm-7">
                        <label for="txtproducto1" class="col-form-label">Producto:</label>
                        <input type="text" class="form-control" id="txtproducto1" name="nombre">
                    </div>
                    <div class="col-sm-5">
                        <label for="txtfecha1" class="col-form-label">Fecha Registro:</label>
                        <input type="date" class="form-control" id="txtfecha1" name="fechareg">
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcalle1" class="col-form-label">Calle:</label>
                        <input type="text" class="form-control" id="txtcalle1" name="calle">
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcolonia1" class="col-form-label">Colonia:</label>
                        <input type="text" class="form-control" id="txtcolonia1" name="colonia">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtcodigopostal1" class="col-form-label">Codigo Postal:</label>
                        <input type="text" class="form-control" id="txtcodigopostal1" name="codigopos">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtestado1" class="col-form-label">Estado:</label>
                        <input type="text" class="form-control" id="txtestado1" name="estado">
                    </div>
                    <div class="col-sm-4">
                        <label for="txtpais1" class="col-form-label">Pais:</label>
                        <input type="text" class="form-control" id="txtpais1" name="pais">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" id="btn-guardar1">Guardar</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="ModalEliminar" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog ">
        <div class="modal-content ">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel2">Eliminar</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="row g-3" id="frmEliminar" method="POST" action="">
                    <input type="hidden" name="txtidproducto" id="txtidprod1" value="">
                    <div class="col-sm-11">
                        <label for="txtproducto2" class="col-form-label">Producto:</label>
                        <input type="text" class="form-control" id="txtproducto2" disabled>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-danger" id="btn-guardar2">Eliminar</button>
                <button type="button" class="btn btn-primary" id="btn-bajatempo">Baja Temporal</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="Modaldetalles" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content col-sm-12">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel3">Modificar</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="row g-3">
                    <input type="hidden" name="txtidproducto" id="txtidprod2" value="">
                    <div class="col-sm-7">
                        <label for="txtproducto1" class="col-form-label">Producto:</label>
                        <input type="text" class="form-control" id="txtproducto21" disabled>
                    </div>
                    <div class="col-sm-5">
                        <label for="txtfecha1" class="col-form-label">Fecha Registro:</label>
                        <input type="date" class="form-control" id="txtfecha21" disabled>
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcalle1" class="col-form-label">Calle:</label>
                        <input type="text" class="form-control" id="txtcalle21" disabled>
                    </div>
                    <div class="col-sm-12">
                        <label for="txtcolonia1" class="col-form-label">Colonia:</label>
                        <input type="text" class="form-control" id="txtcolonia21" disabled>
                    </div>
                    <div class="col-sm-4">
                        <label for="txtcodigopostal1" class="col-form-label">Codigo Postal:</label>
                        <input type="text" class="form-control" id="txtcodigopostal21" disabled>
                    </div>
                    <div class="col-sm-4">
                        <label for="txtestado1" class="col-form-label">Estado:</label>
                        <input type="text" class="form-control" id="txtestado21" disabled>
                    </div>
                    <div class="col-sm-4">
                        <label for="txtpais1" class="col-form-label">Pais:</label>
                        <input type="text" class="form-control" id="txtpais21" disabled>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="${context}/assets/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${context}/assets/plugins/bootstrap/js/bootstrap.bundle.js"></script>
<script src="${context}/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
</body>
<script src="${context}/assets/dist/js/funciones.js"></script>
</html>


