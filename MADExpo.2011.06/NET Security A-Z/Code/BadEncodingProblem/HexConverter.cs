using System;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Windows.Data;

namespace BadEncodingProblem
{
    public class ToHexConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            var str = value as String;
            if (str == null)
            {
                return value;
            }
            var bytes = Encoding.ASCII.GetBytes(str);
            bytes = SHA1.Create().ComputeHash(bytes);
            return bytes.Aggregate(new StringBuilder(), (s, b) => s.AppendFormat("{0:X} ", b)).ToString();
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
