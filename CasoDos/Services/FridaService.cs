using System.Text;
using CasoDos.Models;
using Newtonsoft.Json;

namespace CasoDos.Services;

/// <summary>
/// Service implementing Frida LLM API communication.
/// </summary>
public class FridaService : IFridaService
{
    private readonly HttpClient _httpClient;
    private const string BaseUrl = "https://frida-llm-api.azurewebsites.net";

    /// <summary>
    /// Constructor for FridaService.
    /// </summary>
    /// <param name="httpClient">Injected HttpClient instance.</param>
    public FridaService(HttpClient httpClient)
    {
        _httpClient = httpClient;
        _httpClient.DefaultRequestHeaders.Authorization =
            new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", "B61u304FFVCtzsk0hx1y");
    }

    /// <summary>
    /// Checks the health status of the Frida API.
    /// </summary>
    public async Task<string> CheckHealthAsync()
    {
        var response = await _httpClient.GetAsync($"{BaseUrl}/health");
        response.EnsureSuccessStatusCode();
        return await response.Content.ReadAsStringAsync();
    }

    /// <summary>
    /// Calls /v1/chat/completions endpoint
    /// </summary>
    public async Task<ChatCompletionResponse> GetChatCompletionsAsync(FridaResponseRequest request)
    {
        try
        {
            var json = JsonConvert.SerializeObject(request);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            Console.WriteLine($"Sending request to: {BaseUrl}/v1/chat/completions");
            Console.WriteLine($"Request body: {json}");

            var response = await _httpClient.PostAsync($"{BaseUrl}/v1/chat/completions", content);

            var responseContent = await response.Content.ReadAsStringAsync();

            Console.WriteLine($"Response Status: {response.StatusCode}");
            Console.WriteLine($"Response Body: {responseContent}");

            // Ensure the request was successful, will throw HttpRequestException if not
            response.EnsureSuccessStatusCode();

            var result = JsonConvert.DeserializeObject<ChatCompletionResponse>(responseContent);
            return result!;
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine($"HTTP Error: {ex.Message}");
            Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            throw;
        }
        catch (JsonException ex)
        {
            Console.WriteLine($"JSON Deserialization Error: {ex.Message}");
            Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            throw;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Unexpected Error: {ex.Message}");
            Console.WriteLine($"Stack Trace: {ex.StackTrace}");
            throw;
        }
    }

    /// <summary>
    /// Calls /v1/completions endpoint
    /// </summary>
    /// <param name="request">Completion request data.</param>
    /// <returns>Completion response</returns>
    public async Task<FridaCompletionResponse> GetCompletionsAsync(FridaCompletionRequest request)
    {
        var client = new HttpClient();
        client.DefaultRequestHeaders.Add("accept", "application/json");
        client.DefaultRequestHeaders.Add("Authorization", "Bearer B61u304FFVCtzsk0hx1y");

        var response = await client.PostAsJsonAsync(
            "https://frida-llm-api.azurewebsites.net/v1/chat/completions", 
            request
        );

        var result = await response.Content.ReadFromJsonAsync<FridaCompletionResponse>();
        return result!;
    }

    /// <summary>
    /// Calls /v1/embeddings endpoint
    /// </summary>
    /// <param name="request">Embeddings request data.</param>
    /// <returns>Embeddings response</returns>
    public async Task<ChatCompletionResponse> GetResponsesAsync(FridaResponseRequest request)
    {
        var json = JsonConvert.SerializeObject(request);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        var response = await _httpClient.PostAsync($"{BaseUrl}/v1/responses", content);
        response.EnsureSuccessStatusCode();
        var responseContent = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<ChatCompletionResponse>(responseContent)!;
    }

    /// <summary>
    /// Calls /v1/models endpoint
    /// </summary>
    /// <returns>Models response</returns>
    public async Task<FridaModelsResponse> GetModelsAsync()
    {
        var response = await _httpClient.GetAsync($"{BaseUrl}/v1/models");
        response.EnsureSuccessStatusCode();
        var responseContent = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<FridaModelsResponse>(responseContent)!;
    }
}