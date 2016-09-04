<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="TropicalServer.Styles.UserLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="~/AppThemes/TropicalStyles/UserLogin.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <script>
        /*
        function check(){
        if (document.getElementById("txtid").value == ""
    ) {
            alert("You don't even have an ID??");
            return false;
        }
        else if (document.getElementById("txtpass").value == "") {
            alert("You don't even have a password??");
            return false;
        }
       }
       */
    </script>
    <form id="form1" runat="server">
    <div class="page">
        <div class="header">            
            
                <asp:Image ID="Image" runat="server" 
                     CssClass="imageHeader" ImageUrl="~/Images/HeaderTropicalServer.png" />          
        </div>
        <div class ="login">
            <table id ="login">
                <tr>
                    <td>
                        Molibe Customer Order Tracking
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        <table id= "insidelog">
                            <tr >
                                <td>
                                    Login ID:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtid" runat="server"></asp:TextBox>
             
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTxtId" runat="server" 
                                        ErrorMessage="You need to enter an ID" 
                                        ControlToValidate ="txtid"></asp:RequiredFieldValidator>
                                 </td>

                                   
                            </tr>
                            <tr>
                                <td>
                                    Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpass" TextMode="password" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtpass" runat="server" ErrorMessage="You need to enter an password"
                                        ControlToValidate ="txtpass"></asp:RequiredFieldValidator>
                               
                                </td>
                            </tr>
                            <tr>
                                <td>remember me
                                    <asp:CheckBox ID="chkremember" checked= "true" runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="Button1" CausesValidation="true" runat="server" Text="log in "  OnClick="Button1_Click" />
                                </td>
         </tr>
                         </table>
                    </td>
                </tr>
                                   
                            <tr>
                                <td>
                                     <asp:ValidationSummary 
                              id="valSum" 
                              DisplayMode="BulletList" 
                              runat="server"
                              HeaderText="" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="UserLogin.aspx"> Forget id</a>
                                
                                    <a href="ForgetPassword.aspx"> Forget password</a>
                                </td>
                            </tr>
                       
                 
            </table>
        </div>


    </div>
    </form>
</body>
</html>
