using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace DippCamera
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class GalleryPage : ContentPage
    {
        public GalleryPage()
        {
            InitializeComponent();
            if (Model.SavedImages.img != null)
                imageView = Model.SavedImages.img;
        }
        
    }
}