using Newtonsoft.Json;

namespace CasoDos.Models
{
    public partial class FridaResponseRequest
    {
        [JsonProperty("model")]
        public string? Model { get; set; }

        [JsonProperty("messages")]
        public List<Message>? Messages { get; set; }

        [JsonProperty("stream")]
        public bool Stream { get; set; }

        [JsonProperty("enable_caching")]
        public bool EnableCaching { get; set; }
    }

    public partial class Message
    {
        [JsonProperty("role")]
        public string? Role { get; set; }

        [JsonProperty("content")]
        public List<Content>? Content { get; set; }
    }

    public partial class Content
    {
        [JsonProperty("type")]
        public string? Type { get; set; }

        [JsonProperty("text", NullValueHandling = NullValueHandling.Ignore)]
        public string? Text { get; set; }

        [JsonProperty("image_url", NullValueHandling = NullValueHandling.Ignore)]
        public ImageUrl? ImageUrl { get; set; }
    }

    public partial class ImageUrl
    {
        [JsonProperty("url")]
        public string? Url { get; set; }

        [JsonProperty("detail")]
        public string? Detail { get; set; }
    }
}