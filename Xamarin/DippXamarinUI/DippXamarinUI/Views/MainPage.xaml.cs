using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace DippXamarinUI.Views
{
    public partial class MainPage : ContentPage
    {
        string radioValue;
        public MainPage()
        {
            InitializeComponent();
            var radioValue = "";
            var pickerList = new List<String>();    //nastavení hodnot ve výběru
            pickerList.Add("Option 1");
            pickerList.Add("Option 2");
            pickerList.Add("Option 3");
            pickerList.Add("Option 4");
            pickerList.Add("Option 5");

            picker.ItemsSource = pickerList;
            picker.SelectedIndex = 0;
        }

        private void Button_Clicked(object sender, EventArgs e)
        {
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();

            Console.WriteLine("{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}", entryText.Text, entryNumber.Text, entryPassword.Text, entryDate.Date, entryTime.Time, radioValue, picker.SelectedIndex, entrySwitch.IsToggled, checkbox.IsChecked);

            stopwatch.Stop();
            Console.WriteLine("Time elapsed: {0}", stopwatch.Elapsed);
        }

        void OnColorsRadioButtonCheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            RadioButton button = sender as RadioButton;
            radioValue = (string)button.Content;
        }
    }
}