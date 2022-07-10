using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using Xamarin.Forms;

namespace DippCamera.Model
{
    public class SavedImages
    {


        public static List<MyImage> images = new List<MyImage>();
        public static String name { get; set; }
        public static Image img { get; set; }
        public static byte[] data { get; set; }

      
    }
}
