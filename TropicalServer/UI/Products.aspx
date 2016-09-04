<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/TropicalServer.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="TropicalServer.UI.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <div class="productCategories">
        <asp:Label ID="Label1"  cssclass="productCategoriesLabel"
             runat="server" Text="Product Categories"></asp:Label>

         <table class="RepeaterTable" >
            
            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                    <ItemTemplate>

                <tr class="productCategoriesButton">
                    <td>
                    <asp:LinkButton  ID="LinkButton1" cssclass="productCategoriesButton" 
                    runat="server" CommandArgument='<%# Eval("ItemTypeID") %>'
                        text='<%# Eval("ItemTypeDescription") %>' >
                    </asp:LinkButton>
                        </td>
                </tr>
                    </ItemTemplate>
             </asp:Repeater>
         </table>
                </div>    


    <div class ="chartdisplay">
    <asp:GridView  ID="itemGrid" runat="server" allowpaging="true" pagesize="5"
        PersistedSelection="true" 
         AlternatingRowStyle-CssClass="chartAlternatingItemStyle" OnPageIndexChanging="itemGrid_PageIndexChanging"
        RowStyle-CssClass="chartItemStyle" HeaderStyle-CssClass="chartHeaderStyle"
        cssclass="dataGrid"
        >
        <pagersettings Mode="NextPrevious" position="Bottom" 
            NextPageText="Next" PreviousPageText="Previous" />
    </asp:GridView>
        </div>
     
</asp:Content>

