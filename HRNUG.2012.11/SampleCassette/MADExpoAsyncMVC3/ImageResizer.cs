using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Windows;
using System.Windows.Media.Imaging;
using System.Windows.Media;

namespace MADExpoAsync
{
	public static class ImageResizer
	{
		public static Stream ResizeImage(byte[] image, int size)
		{
			using (var imageStream = new MemoryStream(image))
			{
				var bitmap = BitmapDecoder.Create(imageStream, BitmapCreateOptions.PreservePixelFormat, BitmapCacheOption.None).Frames[0];
				int width = bitmap.Width > bitmap.Height ? size : (int)(bitmap.Width * size / bitmap.Height);
				int height = bitmap.Width > bitmap.Height ? (int)(bitmap.Height * size / bitmap.Width) : size;
				var transformedBitmap = new TransformedBitmap(bitmap, new ScaleTransform(width / bitmap.Width, height / bitmap.Height, 0, 0));
				var resizedBitmap = BitmapFrame.Create(transformedBitmap);
				var convertedBitmap = new FormatConvertedBitmap(resizedBitmap, PixelFormats.Bgra32, null, 0);
				int stride = convertedBitmap.PixelWidth * (convertedBitmap.Format.BitsPerPixel / 8);
				byte[] data = new byte[stride * convertedBitmap.PixelHeight];
				convertedBitmap.CopyPixels(data, stride, 0);
				var writeBitmap = new WriteableBitmap(size, size, convertedBitmap.DpiX, convertedBitmap.DpiY, PixelFormats.Bgra32, null);
				writeBitmap.WritePixels(new Int32Rect(0, 0, convertedBitmap.PixelWidth, convertedBitmap.PixelHeight), data, stride, 0);
				MemoryStream resizeStream = new MemoryStream();
				PngBitmapEncoder decoder = new PngBitmapEncoder();
				decoder.Frames.Add(BitmapFrame.Create(writeBitmap));
				decoder.Save(resizeStream);
				resizeStream.Position = 0;
				return resizeStream;
			}
		}
	}
}