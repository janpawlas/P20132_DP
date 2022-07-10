using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Text;

namespace DippXamarinApi ///definice vzhledu json dat z API
{
    public class Game
    {
        public string name { get; set; }
        public string price { get; set; }
        public string thumb_url { get; set; }
    }

    public class Root
    {
        public List<Game> games { get; set; }
        public string count { get; set; }
    }


}
