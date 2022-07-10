using System;
using System.Collections.Generic;
using System.Text;

namespace DippXamarinDB
{
    class EntryDB   //definice dat v DB
    {
        public int Id { get; set;}
        public string Name { get; set; }

        public override string ToString()
        {
            return "entry: " + this.Id + " " + this.Name;
        }
    }
}
