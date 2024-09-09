using System;
using System.Collections.Generic;

namespace WebApi_Everest_Intelligent.Models;

public partial class Producto
{
    public int IdProducto { get; set; }

    public string? Nombre { get; set; }

    public string? Tipo { get; set; }

    public DateTime? FechaCreacion { get; set; }

    public int? Cantidad { get; set; }

    public double? PrecioUnitario { get; set; }

    public bool? Estado { get; set; }
}
