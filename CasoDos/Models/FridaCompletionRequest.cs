namespace CasoDos.Models;

/// <summary>
/// Request for /v1/completions endpoint.
/// </summary>
public class FridaCompletionRequest
{
    public string Model { get; set; } = "";
    public string Prompt { get; set; } = "";
    public int? MaxTokens { get; set; }
    public double? Temperature { get; set; }
    public double? TopP { get; set; }
    public int? N { get; set; }
    public bool? Stream { get; set; }
    public IList<string>? Stop { get; set; }
    public double? FrequencyPenalty { get; set; }
    public double? PresencePenalty { get; set; }
    public int? Logprobs { get; set; }
    public bool? Echo { get; set; }
    public object? LogitBias { get; set; }
    public string? User { get; set; }
}