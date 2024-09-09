using Microsoft.AspNetCore.Mvc;
using WebApi_Everest_Intelligent.Datos;
using WebApi_Everest_Intelligent.Models;


namespace WebApi_Everest_Intelligent.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ApiController : ControllerBase
    {
        private readonly ProductoRepository _productoRepository;

        // Inyección de dependencias del repositorio
        public ApiController(ProductoRepository productoRepository)
        {
            _productoRepository = productoRepository;
        }

        // Método GET para obtener la lista de Productos
        [HttpGet("ObtenerProductos")]
        public async Task<IActionResult> ObtenerProducto()
        {
            var productos = await _productoRepository.ObtenerProductosAsync();
            return Ok(productos);
        }

        // Método GET para Producto por ID
        [HttpGet("ObtenerProductoId")]
        public async Task<IActionResult> ObtenerProductoId(int id)
        {
            var producto = await _productoRepository.ObtenerProductosIdAsync(id);
            if (producto == null)
            {
                return NotFound();
            }
            return Ok(producto);
        }

        // Método POST para crear un nuevo Producto
        [HttpPost("CrearProducto")]
        public async Task<IActionResult> CrearProducto([FromBody] Producto producto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            await _productoRepository.CrearProductosAsync(producto);
            return Ok(producto);
        }

        // Método PUT para actualizar un Producto
        [HttpPut("ModificarProducto")]
        public async Task<IActionResult> EditarProducto(int id, [FromBody] Producto producto)
        {
            if (id != producto.IdProducto || !ModelState.IsValid)
            {
                return BadRequest();
            }

            await _productoRepository.EditarProductosAsync(producto);
            return NoContent();
        }

        // Método DELETE para borrar un Producto
        [HttpDelete("EliminarProducto")]
        public async Task<IActionResult> BorrarProducto(int id)
        {
            var producto = await _productoRepository.ObtenerProductosIdAsync(id);
            if (producto == null)
            {
                return NotFound();
            }

            await _productoRepository.BorrarProductosAsync(id);
            return NoContent();
        }
    }
}

