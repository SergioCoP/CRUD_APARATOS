

const listarProductos = () =>{
    const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

    $.ajax({
        type: 'GET',
        url: contextPath + '/ServletActions?action=Listar'
    }).done(function(response){
          console.log(response);
        var dproducto = response;
        let table = "";
        $('#Cont_productos').empty();
        $.each(dproducto, function(i,item){
             //console.log(item.name);
            let list = item;
            if(list.length > 0){
                for(let i = 0; i < list.length; i++){
                    let stat = list[i].status;
                    var estado;
                    var acciones;
                    if(stat===1){
                        estado = `<span class="badge bg-success">Activo</span>`;
                        acciones = `
                         <button type="button" class="btn btn-primary btn-sm btn-modificar" data-bs-target="#Modalmodificar" data-bs-toggle="modal" data-idprod="${list[i].idproducto}" data-nombre="${list[i].nombre}" data-fechareg="${list[i].fecharegistro}" data-calle="${list[i].idfabricante.calle}" data-colonia="${list[i].idfabricante.colonia}" data-codpost="${list[i].idfabricante.codigopostal}" data-estado="${list[i].idfabricante.estado}" data-pais="${list[i].idfabricante.pais}"> Modificar</button>
                <button type="button" class="btn btn-danger btn-sm btn-eliminar" data-bs-target="#ModalEliminar" data-bs-toggle="modal" data-idprod="${list[i].idproducto}" > Eliminar</button>
                        `;
                    }else{
                        estado = `<span class="badge bg-secondary">Inactivo</span>`;
                        acciones = ` <button type="button" class="btn btn-info btn-sm btn-detalles" data-bs-target="#Modaldetalles" data-bs-toggle="modal" data-idprod="${list[i].idproducto}" > Info</button>`
                    }



                    table += `
            <tr>
                <td>${i+1}</td>
                <td>${list[i].nombre}</td>
                <td>${list[i].idfabricante.calle}, ${list[i].idfabricante.colonia},C.P-${list[i].idfabricante.codigopostal}</td>
                <td>${list[i].idfabricante.pais}</td>
                <td>${estado}</td>
                <td>
                ${acciones}
               <!-- <button type="button" class="btn btn-primary btn-sm btn-modificar" data-bs-target="#Modalmodificar" data-bs-toggle="modal" data-idprod="${list[i].idproducto}" data-nombre="${list[i].nombre}" data-fechareg="${list[i].fecharegistro}" data-calle="${list[i].idfabricante.calle}" data-colonia="${list[i].idfabricante.colonia}" data-codpost="${list[i].idfabricante.codigopostal}" data-estado="${list[i].idfabricante.estado}" data-pais="${list[i].idfabricante.pais}"> Modificar</button>
                <button type="button" class="btn btn-danger btn-sm btn-eliminar" data-bs-target="#ModalEliminar" data-bs-toggle="modal" data-idprod="${list[i].idproducto}" > Eliminar</button>-->
                </td>
            </tr>
            `;

                }
            }else{
                table = `
		`;
            }
            // console.log(item);
            //console.log(table);
            $('#Cont_productos').append(table);

            //    llenartablapago(item);
        })
    })
};


(function() {
    listarProductos();

    $('#btn-guardar').on('click', function () {

        $('#frmregistrar').submit();
    });

    $('#btn-guardar1').on('click', function () {
        $('#frmModificar').submit();
    });

    $('#btn-guardar2').on('click',function () {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        var url = contextPath + '/ServletActions?action=Eliminar';
        console.log(url);
        $('#frmEliminar').attr('action',url);

      //  console.log($('#frmEliminar').attr('action'));
        $('#frmEliminar').submit();
        $('#ModalEliminar .btn-close').click();

        });

    $('#btn-bajatempo').on('click',function () {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        var url = contextPath + '/ServletActions?action=BajaTemporal';
        console.log(url);
        $('#frmEliminar').attr('action',url);

        //  console.log($('#frmEliminar').attr('action'));
        $('#frmEliminar').submit();
        $('#ModalEliminar .btn-close').click();

    });

    $('#Cont_productos').on('click','.btn-modificar',function () {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        let idprod = $(this).attr('data-idprod');

        $.ajax({
            type: 'POST',
            url: contextPath + '/ServletActions?action=BuscarProductoporid',
            data: {idproducto: idprod}
        }).done(function (res) {
            //console.log(res.Producto);
            let user = res.Producto;

            $('#txtidprod').val(user.idproducto);
            $('#txtproducto1').val(user.nombre);
            $('#txtfecha1').val(user.fecharegistro);
            $('#txtcalle1').val(user.idfabricante.calle);
            $('#txtcolonia1').val(user.idfabricante.colonia);
            $('#txtcodigopostal1').val(user.idfabricante.codigopostal);
            $('#txtestado1').val(user.idfabricante.estado);
            $('#txtpais1').val(user.idfabricante.pais);
        })
    });

    $('#Cont_productos').on('click','.btn-eliminar',function () {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        let idprod = $(this).attr('data-idprod');

        $.ajax({
            type: 'POST',
            url: contextPath + '/ServletActions?action=BuscarProductoporid',
            data: {idproducto: idprod}
        }).done(function (res) {
            console.log(res.Producto);
            let user = res.Producto;

            $('#txtidprod1').val(user.idproducto);
            $('#txtproducto2').val(user.nombre);
        })
    });

    $('#Cont_productos').on('click','.btn-detalles',function () {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        let idprod = $(this).attr('data-idprod');

        $.ajax({
            type: 'POST',
            url: contextPath + '/ServletActions?action=BuscarProductoporid',
            data: {idproducto: idprod}
        }).done(function (res) {
            //console.log(res.Producto);
            let user = res.Producto;

            $('#txtidprod2').val(user.idproducto);
            $('#txtproducto21').val(user.nombre);
            $('#txtfecha21').val(user.fecharegistro);
            $('#txtcalle21').val(user.idfabricante.calle);
            $('#txtcolonia21').val(user.idfabricante.colonia);
            $('#txtcodigopostal21').val(user.idfabricante.codigopostal);
            $('#txtestado21').val(user.idfabricante.estado);
            $('#txtpais21').val(user.idfabricante.pais);
        })
    });

    $('#frmregistrar').submit(function (e) {
        const contextPath = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

        e.preventDefault();
        var form = $(this);
        var url = form.attr('action');
        console.log(url);
        $.ajax({
            type: 'POST',
            url: contextPath + url,
            data: {
                txtnombre: $('#txtproducto').val(),
                txtfechareg: $('#txtfecha').val(),
                txtcalle: $('#txtcalle').val(),
                txtcolonia: $('#txtcolonia').val(),
                txtcodigopostal: $('#txtcodigopostal').val(),
                txtestado: $('#txtestado').val(),
                txtpais: $('#txtpais').val()}
        }).done(function (data) {
            console.log("Registrado");

            listarProductos();
            $('#Modalregistro .btn-close').click();
        }).fail(function(data) {
            console.log("Error Al registrar");
        });
    })

})();
