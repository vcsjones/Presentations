using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Data;

namespace EncodingSample
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
            return bytes.Aggregate(new StringBuilder(), (s, b) => s.AppendFormat("{0:X} ", b)).ToString();
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
    public class FromHexConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            var str = value as String;
            if (String.IsNullOrEmpty(str))
            {
                return value;
            }
            var bytes = str.Split(new [] {" "}, StringSplitOptions.RemoveEmptyEntries).Select(s => System.Convert.ToByte(s, 16)).ToArray();
            return Encoding.ASCII.GetString(bytes);
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
