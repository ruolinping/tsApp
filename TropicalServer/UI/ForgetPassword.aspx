<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="TropicalServer.UI.ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/AppThemes/TropicalStyles/UserLogin.css" rel="stylesheet" type="text/css" />
</head>
<body>
        <script>
            /*
        function check() {
            if (document.getElementById("txtid").value == ""
                ) {
                alert("You don't even have an ID??");
            }
            else if (document.getElementById("txtpass").value == "") {
                alert("You need to enter a password??");
            }
            else if (document.getElementById("txtpass_again").value == "") {
                alert("You need to re-enter a password??");
            }
            else if (document.getElementById("txtpass").value != document.getElementById("txtpass_again").value)
                alert("You need to re-enter the sameeeeeee password??");
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
                        Reset Your Password
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
                                        ControlToValidate ="txtid" validationgroup="check"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpass" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatortxtpass" runat="server" ErrorMessage="You need to enter an password"
                                        ControlToValidate ="txtpass" ValidationGroup="check"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Retype Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="txtpass_again" runat="server" TextMode="Password"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="You need to enter an password"
                                        ControlToValidate ="txtpass_again" ValidationGroup="check"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidatorPassword" runat="server" 
                                        ControlToValidate="txtpass_again" ControlToCompare="txtpass" Operator="equal"
                                        Type ="String"
                                        ErrorMessage="The retyped password doesn't match" ValidationGroup="check"></asp:CompareValidator>
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
                              HeaderText="" ValidationGroup="check"/>
                                </td>
                            </tr>
                <tr>

                    <td>
                        <asp:Button ID="Button2" runat="server" Text="Clear" OnClick="Button2_Click" />
                        <asp:Button ID="Button1" runat="server" Text="Confirm" OnClick="Button1_Click" validationgroup="check"/>
                    
                    </td>
                </tr>          
                       
                 
            </table>
        </div>


    </div>
    </form>
</body>
</html>
