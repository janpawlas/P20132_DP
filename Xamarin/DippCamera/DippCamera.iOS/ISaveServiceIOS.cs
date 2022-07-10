using cameraviewDemo.iOS;
using Foundation;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using UIKit;
using static DippCamera.CameraPage;

[assembly: Xamarin.Forms.Dependency(typeof(SaveService))]
namespace cameraviewDemo.iOS
{
    class SaveService : ISaveService
    {
        void ISaveService.SaveFile(string fileName, byte[] data)
        {
            var documents = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            var filename = Path.Combine(documents, fileName);
            File.WriteAllBytes(filename, data);
        }
    }
}