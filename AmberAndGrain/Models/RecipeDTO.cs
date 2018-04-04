using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AmberAndGrain.Models
{
    public class RecipeDTO
    {
        public string name { get; set; }
        public decimal percentWheat { get; set; }
        public decimal percentCorn { get; set; }
        public int barrelAge { get; set; }
        public string barrelMaterial { get; set; }
        public string creator { get; set; }
    }
}