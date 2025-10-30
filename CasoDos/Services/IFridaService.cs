// Services/IFridaService.cs

using CasoDos.Models;

namespace CasoDos.Services;

/// <summary>
/// Interface for Frida service to abstract API calls.
/// </summary>
public interface IFridaService
{
    Task<string> CheckHealthAsync();
    Task<ChatCompletionResponse> GetChatCompletionsAsync(FridaResponseRequest request);
    Task<FridaCompletionResponse> GetCompletionsAsync(FridaCompletionRequest request);
    Task<ChatCompletionResponse> GetResponsesAsync(FridaResponseRequest request);
    Task<FridaModelsResponse> GetModelsAsync();
}