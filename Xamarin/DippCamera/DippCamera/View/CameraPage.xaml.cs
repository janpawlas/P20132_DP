using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.CommunityToolkit.UI.Views;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace DippCamera
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class CameraPage : ContentPage
    {
        public CameraPage()
        {
            InitializeComponent();
        }

        private void XctCameraView_MediaCaptured(object sender, MediaCapturedEventArgs e)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            Image image = new Image { Source = e.Image };
            byte[] data = e.ImageData;
            saveImageToGallery(data); //ukládání  dat do zařízení
            /*          pokus o implementaci uložení v aplikaci
            Model.SavedImages.images.Add(new Model.MyImage(image, data));
            Model.SavedImages.img = image;
            Model.SavedImages.data = data;
            Model.SavedImages.name = "ahoj";
            //byte[] image = e.ImageData;
            //Console.WriteLine(Model.SavedImages.images.Count);
            //Console.WriteLine(Model.SavedImages.images[0].data.Length);
            //Console.WriteLine(Model.SavedImages.images[0].name);
            */
            stopwatch.Stop();
            Console.WriteLine("Time elapsed: {0}", stopwatch.Elapsed);
        }

        private void CaptureImageBtn(object sender, EventArgs e)
        {
            xctCameraView.Shutter();
        }

        private void saveImageToGallery(byte[] data)    //metoda, která generuje název pořízené fotky a následně volá jednotlivé implementace rozhraní pro ukládání fotografie
        {
            string fileName = "xamarin" + DateTime.Now.ToFileTime() + ".jpg";
            DependencyService.Get<ISaveService>().SaveFile(fileName, data);
        }
        public interface ISaveService   //definice rozhraní pro ukládání do zařízení
        {
            void SaveFile(string fileName, byte[] data);

        }
    }
}

