using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using cameraviewDemo.Droid;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using static DippCamera.CameraPage;

[assembly: Xamarin.Forms.Dependency(typeof(SaveService))]
namespace cameraviewDemo.Droid
{
    public class SaveService : ISaveService
    {
        public SaveService()
        {
        }

        void ISaveService.SaveFile(string fileName, byte[] data)
        {
            string picPath = Path.Combine(Application.Context.GetExternalFilesDir(null).AbsolutePath, Android.OS.Environment.DirectoryPictures);
            string filePath = Path.Combine(picPath, fileName);
            if (!Directory.Exists(picPath))
            {
                Directory.CreateDirectory(picPath);
            }
            File.WriteAllBytes(filePath, data);
        }
    }
}