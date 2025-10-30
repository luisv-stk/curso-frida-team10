// Models/FridaChatCompletionRequest.cs

namespace CasoDos.Models;

/// <summary>
/// Model for chat completion request as expected by Frida LLM API.
/// </summary>
public class FridaChatCompletionRequest
{
    public string? Model { get; set; }
    public List<FridaMessage>? Messages { get; set; }
    public float? Temperature { get; set; }
    public int? MaxTokens { get; set; }
}

/// <summary>
/// Model for chat messages.
/// </summary>
public class FridaMessage
{
    public string? Role { get; set; }
    public string? Content { get; set; }
}