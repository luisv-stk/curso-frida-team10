// Models/FridaChatCompletionResponse.cs

namespace CasoDos.Models;

/// <summary>
/// Model for chat completion response from Frida LLM API.
/// </summary>
public class FridaChatCompletionResponse
{
    public string? Id { get; set; }
    public string? Object { get; set; }
    public long? Created { get; set; }
    public List<FridaChoice>? Choices { get; set; }
}

/// <summary>
/// Model for response choices.
/// </summary>
public class FridaChoice
{
    public int? Index { get; set; }
    public FridaMessage? Message { get; set; }
    public string? FinishReason { get; set; }
}