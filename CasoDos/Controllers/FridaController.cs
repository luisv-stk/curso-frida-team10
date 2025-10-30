using Microsoft.AspNetCore.Mvc;
using CasoDos.Services;
using CasoDos.Models;

namespace CasoDos.Controllers;

/// <summary>
/// API Controller to handle requests related to the Frida LLM API.
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class FridaController : ControllerBase
{
    private readonly IFridaService _fridaService;

    /// <summary>
    /// Constructor for FridaController.
    /// </summary>
    /// <param name="fridaService">Injected Frida service.</param>
    public FridaController(IFridaService fridaService)
    {
        _fridaService = fridaService;
    }

    /// <summary>
    /// Calls the /health endpoint to check Frida API status.
    /// </summary>
    [HttpGet("health")]
    public async Task<IActionResult> GetHealthAsync()
    {
        var result = await _fridaService.CheckHealthAsync();
        return Ok(result);
    }

    /// <summary>
    /// Calls the /v1/chat/completions endpoint to get chat completions.
    /// </summary>
    /// <param name="request">Chat completion request data.</param>
    [HttpPost("chat/completions")]
    public async Task<IActionResult> GetChatCompletionsAsync([FromBody] FridaResponseRequest request)
    {
        var response = await _fridaService.GetChatCompletionsAsync(request);
        return Ok(response);
    }

    /// <summary>
    /// Calls the /v1/completions endpoint to get completions.
    /// </summary>
    /// <param name="request">Completion request data.</param>
    [HttpPost("completions")]
    public async Task<IActionResult> GetCompletionsAsync([FromBody] FridaCompletionRequest request)
    {
        var response = await _fridaService.GetCompletionsAsync(request);
        return Ok(response);
    }

    /// <summary>
    /// Calls the /v1/embeddings endpoint to get embeddings.
    /// </summary>
    /// <param name="request">Embeddings request data.</param>
    [HttpPost("responses")]
    public async Task<IActionResult> GetResponsesAsync([FromBody] FridaResponseRequest request)
    {
        var response = await _fridaService.GetResponsesAsync(request);
        return Ok(response);
    }

    /// <summary>
    /// Calls the /v1/models endpoint to list available models.
    /// </summary>
    [HttpGet("models")]
    public async Task<IActionResult> GetModelsAsync()
    {
        var response = await _fridaService.GetModelsAsync();
        return Ok(response);
    }

    [HttpGet("image")]
    public async Task<IActionResult> GetImage()
    {
        string imagePath = @"C:\Users\oscar.mellado\workspace\Frida\TomateOrlando.jpg";

        // 1. Leer la imagen como bytes
        byte[] imageBytes = System.IO.File.ReadAllBytes(imagePath);

        // 2. Convertir a Base64
        string base64String = Convert.ToBase64String(imageBytes);

        return Ok(base64String);
    }
}