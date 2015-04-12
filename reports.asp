<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cpf.asp" -->
<!--#include file="logout.asp" -->
<%
	Response.CharSet = "UTF-8"

	Dim objCon
	Set objCon = Server.CreateObject("ADODB.Connection")
		objCon.Open MM_cpf_STRING
%>
<!DOCTYPE html>
<html>
<head>
	<title>:: DAEE ::</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="css/bootstrap-flaty.min.css">
	<link rel="stylesheet" type="text/css" href="css/daee.css">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<script type="text/javascript" src="js/fullscreen.js"></script>
	<script type="text/javascript" src="js/datepicker-pt-BR.js"></script>
	<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function clearForm() {
			$("#cod_municipio").val("");
			$("#cod_municipio").trigger("change");

			$("#cod_empreendimento").val("");
			$("#cod_empreendimento").trigger("change");

			$("#general_info").removeAttr("checked")
			$("#situation_overview").removeAttr("checked")
		}
				
		$(function() {
			$(".datepicker").datepicker($.datepicker.regional["pt-BR"]);

			$(".input-group-addon.calendar, .fa-calendar").on("click", function() {
				$(".datepicker").trigger("focus");
			});

			var selectedDate;

			$("#data.datepicker").on("change", function() {
				selectedDate = $(this).val();
				var cod_empreendimento = $("#cod_empreendimento").val();

				if(selectedDate){
					if (optionSelected) {
						optionData = optionSelected.data();
						if(!optionData.habilitaBotoes && optionData.exibeData && cod_empreendimento != ""){
							$("#btnClearForm").removeAttr("disabled");
							$("#btnGenerateReport").removeAttr("disabled");
						}
					}
				}
			});

			var optionSelected = $("#modelo_relatorio option:selected")
			if(optionSelected){
				optionData = optionSelected.data();

				if(optionData.exibeData)
					$("#data").closest("div.row").removeClass("hide");
				else if(!$("#data").closest("div.row").hasClass("hide"))
					$("#data").closest("div.row").addClass("hide");
			}

			$("#btnGenerateReport").on("click", function(){
				$(this).button("loading");
				var report_page = $("#modelo_relatorio").val();
				var cod_mun = $("#cod_municipio").val();
				var cod_emp = $("#cod_empreendimento").val();

				if(cod_mun != "")
					report_page += "?cod_municipio=" + cod_mun

				if(cod_emp != "")
					report_page += "&cod_empreendimento=" + cod_emp

				if (optionSelected) {
					optionData = optionSelected.data();
					if(optionData.exibeData && selectedDate){
						report_page += "&data=" + selectedDate
					}
				}

				window.location.href = report_page
			});

			$("#btnClearForm").on("click", function(){
				clearForm();
			});

			$("#cod_municipio").on("change", function() {
				var cod_modelo_relatorio = $("#modelo_relatorio").val();
				var cod_mun = $("#cod_municipio").val();
				var url = "reports.asp";

				if(cod_mun != ""){
					$("#btnClearForm").removeAttr("disabled");
					$("#btnGenerateReport").removeAttr("disabled");
				}

				if((cod_mun != "") && !$("#cod_empreendimento").closest("div.row").hasClass("hide")){
					url += "?cod_modelo_relatorio="+ cod_modelo_relatorio +"&cod_mun=" + cod_mun;

					if(cod_modelo_relatorio == "informacao-obra-andamento.asp")
						url += "&filtra_situacao=sim";
				}
				
				if(!$("#cod_empreendimento").closest("div.row").hasClass("hide"))
					location.replace(url);
			});

			$("#cod_empreendimento").on("change", function() {
				var cod_empreendimento = $("#cod_empreendimento").val();

				if(cod_empreendimento != ""){
					if (optionSelected) {
						optionData = optionSelected.data();
						if(optionData.habilitaBotoes){
							$("#btnClearForm").removeAttr("disabled");
							$("#btnGenerateReport").removeAttr("disabled");
						}
						else if(!optionData.habilitaBotoes && optionData.exibeData && selectedDate){
							$("#btnClearForm").removeAttr("disabled");
							$("#btnGenerateReport").removeAttr("disabled");
						}
					}

				}
			});

			$("#modelo_relatorio").on("change", function(e) {
				optionData = $("#modelo_relatorio option:selected").data();

				if(optionData.habilitaBotoes) {
					$("#btnClearForm").removeAttr("disabled");
					$("#btnGenerateReport").removeAttr("disabled");
				}
				else {
					if(!$("#btnClearForm").attr("disabled"))
						$("#btnClearForm").attr("disabled","disabled");
					
					if(!$("#btnGenerateReport").attr("disabled"))
						$("#btnGenerateReport").attr("disabled","disabled");
				}

				$("#cod_municipio").val("");
				$("#cod_empreendimento").val("");

				if(optionData.exibeMunicipio){
					$("#cod_municipio").closest("div.row").removeClass("hide");
				}
				else if(!$("#cod_municipio").closest("div.row").hasClass("hide"))
					$("#cod_municipio").closest("div.row").addClass("hide");

				if(optionData.exibeLocalidade) {
					$("#cod_empreendimento").closest("div.row").removeClass("hide");
				}
				else if(!$("#cod_empreendimento").closest("div.row").hasClass("hide"))
					$("#cod_empreendimento").closest("div.row").addClass("hide");

				if(optionData.exibeData) {
					$("#data").closest("div.row").removeClass("hide");
				}
				else if(!$("#data").closest("div.row").hasClass("hide"))
					$("#data").closest("div.row").addClass("hide");


				if( location.search.indexOf("&filtra_situacao=sim") != -1 ){
					var cod_modelo_relatorio = $("#modelo_relatorio").val();
					var url = location.search.replace("&filtra_situacao=sim","").replace("cod_modelo_relatorio=informacao-obra-andamento.asp", "cod_modelo_relatorio="+cod_modelo_relatorio);
					location.replace("reports.asp"+url)
				}
			});
		});
	</script>
</head>
<body>

	<div class="container container-box">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Selecione as informações que deseja visualizar</h3>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-12">	
						<div class="form-group">
							<label class="control-label">Modelo de Relatório:</label>
							<select id="modelo_relatorio" class="form-control">
								<option></option>
								<option 
									<% If Request("cod_modelo_relatorio") <> "" Then If Request("cod_modelo_relatorio") = "ficha-tecnica-obra.asp" Then Response.Write "selected='selected'" End If End If %>
									data-habilita-botoes="true" data-exibe-municipio="true" data-exibe-localidade="true" data-exibe-data="false" value="ficha-tecnica-obra.asp">
									Ficha Técnica da Obra
								</option>
								<option 
									<% If Request("cod_modelo_relatorio") <> "" Then If Request("cod_modelo_relatorio") = "rel_rdo.asp" Then Response.Write "selected='selected'" End If End If %>
									data-habilita-botoes="false" data-exibe-municipio="true" data-exibe-localidade="true" data-exibe-data="true" value="rel_rdo.asp">
									Relatório Diário de obra
								</option>
							</select>
						</div>
					</div>	
				</div>	

				<div class='row <% If Request("cod_modelo_relatorio") = "" Then Response.Write "hide" End If %>'>
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label">Município:</label>
							<select id="cod_municipio" class="form-control">
								<option value=""></option>
								<%
									strQ = "SELECT c_lista_predios.cod_predio, c_lista_predios.nme_municipio FROM c_lista_pi INNER JOIN c_lista_predios ON c_lista_pi.cod_mun = c_lista_predios.id_predio GROUP BY c_lista_predios.cod_predio, c_lista_predios.nme_municipio, c_lista_pi.nme_municipio ORDER BY c_lista_pi.nme_municipio;"

									Set rs_combo = Server.CreateObject("ADODB.Recordset")
										rs_combo.CursorLocation = 3
										rs_combo.CursorType = 3
										rs_combo.LockType = 1
										rs_combo.Open strQ, objCon, , , &H0001

									If Not rs_combo.EOF Then
										While Not rs_combo.EOF
											If Trim(rs_combo.Fields.Item("nme_municipio").Value) <> "" Then
												If Request("cod_mun") <> "" Then
													cod_mun = Request("cod_mun")
													Response.Write "      <OPTION value='" & (rs_combo.Fields.Item("cod_predio").Value) & "'"
													If Lcase(rs_combo.Fields.Item("cod_predio").Value) = Lcase(cod_mun) then
														Response.Write "selected"
													End If
													Response.Write ">" & (rs_combo.Fields.Item("nme_municipio").Value) & "</OPTION>"
												Else
								%>
								<option value="<%=(rs_combo.Fields.Item("cod_predio").Value)%>"><%=(rs_combo.Fields.Item("nme_municipio").Value)%></option>
								<%
												End If
											End If
											rs_combo.MoveNext
										Wend
									End If
								%>
							</select>
						</div>
					</div>
				</div>

				<div class='row <% If Request("cod_mun") = "" Then Response.Write "hide" End If %>'>
					<div class="col-xs-12">
						<div class="form-group">
							<label class="control-label">Localidade:</label>
							<select id="cod_empreendimento" class="form-control">
								<option value=""></option>
								<%
									If Request("cod_mun") <> "" Then
										cod_mun = Request("cod_mun")

										strQ = "SELECT * FROM tb_pi where id_predio = " & cod_mun

										If Request("filtra_situacao") <> "" Then
											strQ = strQ + " AND cod_situacao_externa = 40"
										End If

										Set rs_combo = Server.CreateObject("ADODB.Recordset")
											rs_combo.CursorLocation = 3
											rs_combo.CursorType = 3
											rs_combo.LockType = 1
											rs_combo.Open strQ, objCon, , , &H0001

										If Not rs_combo.EOF Then
											While Not rs_combo.EOF
												If Trim(rs_combo.Fields.Item("PI").Value) <> "" Then
								%>
								<option value="<%=(rs_combo.Fields.Item("PI").Value)%>"><%=(rs_combo.Fields.Item("PI").Value)%> - <%=(rs_combo.Fields.Item("nome_empreendimento").Value)%></option>
								<%
												End If
												rs_combo.MoveNext
											Wend
										End If
									End If
								%>
							</select>
						</div>
					</div>
				</div>

				<div class="row <% If Request("cod_mun") = "" Then Response.Write "hide" End If %>">
					<div class="col-xs-4">
						<div class="form-group">
							<label class="control-label">Data:</label>
							<div class="input-group">
								<input type="text" id="data" class="form-control datepicker">
								<span class="input-group-addon calendar cursor"><i class="fa fa-calendar"></i></span>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="panel-footer clearfix">
				<div class="pull-right">
					<button type="button" id="btnClearForm" disabled="disabled" class="btn btn-default">
						<i class="fa fa-times-circle"></i> Cancelar
					</button>
					<button type="button" id="btnGenerateReport" disabled="disabled" class="btn btn-primary" data-loading-text="Aguarde...">
						<i class="fa fa-files-o"></i> Gerar Relatório
					</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>