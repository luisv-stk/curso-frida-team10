namespace CasoDos.Models;

/// <summary>
/// Response from /v1/completions endpoint.
/// </summary>
public class FridaCompletionResponse
{
    public string Id { get; set; } = "";
    public string Object { get; set; } = "";
    public int Created { get; set; }
    public string Model { get; set; } = "";
    public IList<FridaCompletionChoice> Choices { get; set; } = new List<FridaCompletionChoice>();
    public FridaCompletionUsage Usage { get; set; } = new FridaCompletionUsage();
}

public class FridaCompletionChoice
{
    public string Text { get; set; } = "";
    public int Index { get; set; }
    public object? Logprobs { get; set; }
    public string FinishReason { get; set; } = "";
}

public class FridaCompletionUsage
{
    public int PromptTokens { get; set; }
    public int CompletionTokens { get; set; }
    public int TotalTokens { get; set; }
}