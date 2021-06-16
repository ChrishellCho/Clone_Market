using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Market.Admin
{
	public partial class PasswordEncrypt : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void btnCreate_Click(object sender, EventArgs e)
		{
			// 클리어 텍스트를 암호화된 텍스트로 변환
			lblPassword.Text = Security.Encrypt(txtPassword.Text);
		}
	}
}