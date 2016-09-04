<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication2.WebForm1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
            
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods = "true">  
  
    </asp:ScriptManager>
    <div>
 
    <script  type="text/javascript">
        $(function () {
            //ajax autocomplete extender
            $('#txtIDTest').autocomplete({
            source: function (request, response) {
         $.ajax({
             url: "./Orders2.aspx/getAutoCompleteName",
             data: "{ s: '" + request.term + "'}",
            dataType: "json",
            type: "POST",
            async: "true",
            cache: "false",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                response($.map(data.d, function (item) {
                    return { value: item }
                }))
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert(textStatus);
            }
        });
    }
});
});
        </script>
    <div id="CriteriaBar">
    <asp:Table runat="server" >
        <asp:TableRow>
            <asp:TableCell >
                <div class="Criteria">
                <label class="label">Order Date:</label>
                <asp:DropDownList ID="ddlOrderDate" runat="server" 
                    AutoPostBack="true" OnSelectedIndexChanged="ddlOrderDate_TextChanged">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                    <asp:ListItem Text="Today" Value="Today"></asp:ListItem>
                    <asp:ListItem Text="Last 7 Days" Value="Last7Days" />
                    <asp:ListItem Text="Last one month" Value="Last1Month" />
                    <asp:ListItem Text="Last six month" Value="Last6Month"/>
                </asp:DropDownList>
                    </div>
            </asp:TableCell>
            <asp:TableCell>
                <div class="Criteria">
                <label class="label">Customer ID:</label> <asp:TextBox ID="txtID" runat="server" cssclass="Input"
                    AutoPostBack="true" OnTextChanged="txtID_TextChanged"></asp:TextBox>
                    <input id="txtIDTest" type="text" />
                    
                    </div>
            </asp:TableCell>
            <asp:TableCell>
                 <div class="Criteria">
                <label class="label">Customer Name: </label><asp:TextBox ID="txtCName" runat="server" cssclass="Input"
                    AutoPostBack="true" OnTextChanged="txtCName_TextChanged"></asp:TextBox>
                     </div>
            </asp:TableCell>
            <asp:TableCell>
                <div class="Criteria">
                     <label class="label">
                Sales Manager: </label>
                <asp:DropDownList ID="ddlSalesManager" runat="server" 
                    AutoPostBack="true" OnTextChanged="ddlSalesManager_TextChanged">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                </asp:DropDownList>
                    </div>
            </asp:TableCell>
        </asp:TableRow>
      
    </asp:Table>
        
        </div>
    <asp:Label runat="server" ID ="labelCID">CID:</asp:Label>

    <div id="grid">
        <asp:GridView ID="GridViewOrders" runat="server" DataKeyNames="OrderID" AlternatingRowStyle-CssClass="AltRow"
            AutoGenerateColumns="false" RowStyle-CssClass="Row" CssClass="gvOrders"
            OnRowCommand="GridViewOrders_RowCommand"
            OnRowUpdating="GridViewOrders_RowUpdating" OnSelectedIndexChanged="GridViewOrders_SelectedIndexChanged"
            OnRowEditing="GridViewOrders_RowEditing" OnRowDeleting="GridViewOrders_RowDeleting"
            OnRowCancelingEdit="GridViewOrders_RowCancelingEdit">
            <Columns>
                <asp:TemplateField HeaderText="Tracking #">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="OrderTrackingNumber" Text='<%#Eval("OrderTrackingNumber") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="trackNoEdit" runat="server" Text='<%#Bind("OrderTrackingNumber") %>' ></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Order Date">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="OrderDates" Text='<%#Eval("OrderDates") %>' />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="OrderDatesEdit" runat="server" Text='<%#Bind("OrderDates") %>' ></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                    
                <asp:TemplateField HeaderText="Customer ID">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="OrderCustomerNumber" Text='<%#Eval("[OrderCustomerNumber]") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Customer Name">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="CustName" Text='<%#Eval("[CustName]") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="Address" Text='<%#Eval("[Address]") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Route #">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="OrderRouteNumber" Text='<%#Eval("[OrderRouteNumber]") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:templatefield headertext="Available Actions">
				<itemtemplate>
					<asp:linkbutton id="btnEdit" runat="server" commandname="Edit" text="Edit" />
					<asp:linkbutton id="btnDelete" runat="server" commandname="Delete" text="Delete" />
					<asp:linkbutton id="btnView" runat="server" commandname="Select" text="View"/>
                            
				</itemtemplate>
				<edititemtemplate>
					<asp:linkbutton id="btnUpdate" runat="server" commandname="Update" text="Update" />
					<asp:linkbutton id="btnCancel" runat="server" commandname="Cancel" text="Cancel" />
				</edititemtemplate>
                </asp:templatefield>

            </Columns>
        </asp:GridView>
        <asp:Button ID="btnv" runat="server" style="display:none" />
        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnv"
    CancelControlID="btnClose" BackgroundCssClass="modalBackground">
</cc1:ModalPopupExtender>

        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" style = "display:none">
            <asp:Label ID="txtPanel" runat="server" Text="Label"></asp:Label>
            
            <br />
    <asp:Button ID="btnClose" runat="server" Text="Close" />
</asp:Panel>
    </div>
    </div>
    </form>
</body>
</html>
