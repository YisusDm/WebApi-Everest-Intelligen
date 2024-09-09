using System;
using System.Collections.Generic;

namespace WebApi_Everest_Intelligent.Models;

public partial class Empleado
{
    public int IdEmpleado { get; set; }

    public string? Nombre { get; set; }

    public string? Apellido { get; set; }

    public string? Email { get; set; }

    public string? Celular { get; set; }

    public DateTime? FechaCreacion { get; set; }

    public DateTime? FechaModificacion { get; set; }
}
