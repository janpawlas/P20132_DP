using System;
using System.Diagnostics;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace DippXamarinDB
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class FormPage : ContentPage
    {
        public FormPage()
        {
            InitializeComponent();
            NavigationPage.SetHasBackButton(this, true);
        }

        private void Button_Clicked(object sender, EventArgs e)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            MySql mySql = new MySql();
            if(formName.Text.Length > 0)
            {
                mySql.AddToDB(formName.Text);
            }
            Navigation.PopAsync();
            stopwatch.Stop();
            Console.WriteLine("Time elapsed: {0}", stopwatch.Elapsed);
        }
    }
}