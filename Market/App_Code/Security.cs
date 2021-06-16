using System;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

// Security Class : 보안관련 클래스


	public class Security
	{
		// Encrypt() 메서드 : 문자열 암호화
		// <param name="cleanString">암호화 시킬 문자열</param>
		// <returns>암호화된 문자열</returns>
		// 단점 : 사용자가 비밀번호를 잊었을 시 재발급해야함
		public static string Encrypt(string cleanString)
		{
			Byte[] clearBytes = new UnicodeEncoding().GetBytes(cleanString);
			Byte[] hashedBytes = ((HashAlgorithm)CryptoConfig.CreateFromName("MD5")).ComputeHash(clearBytes);

			return BitConverter.ToString(hashedBytes);
		}
	}