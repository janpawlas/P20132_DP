using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;

namespace DippCamera.Model
{
    public class MyImage
    {
        public String name;
        public Image img { get; set; }
        public byte[] data { get; set; }
        public MyImage(Image source, byte[] data)
        {
            this.img = source;
            this.data = data;
            this.name = "idk foto";
        }

        
    }
}
