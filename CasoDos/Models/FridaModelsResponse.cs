namespace CasoDos.Models;

/// <summary>
/// Response from /v1/models endpoint.
/// </summary>
public class FridaModelsResponse
{
    public string Object { get; set; } = "";
    public IList<FridaModelData> Data { get; set; } = new List<FridaModelData>();
}

public class FridaModelData
{
    public string Id { get; set; } = "";
    public string Object { get; set; } = "";
    public long Created { get; set; }
    public string OwnedBy { get; set; } = "";
    public IList<FridaModelPermission> Permission { get; set; } = new List<FridaModelPermission>();
    public string Root { get; set; } = "";
    public string Parent { get; set; } = "";
}

public class FridaModelPermission
{
    public string Id { get; set; } = "";
    public string Object { get; set; } = "";
    public long Created { get; set; }
    public bool AllowCreateEngine { get; set; }
    public bool AllowSampling { get; set; }
    public bool AllowLogprobs { get; set; }
    public bool AllowSearchIndices { get; set; }
    public bool AllowView { get; set; }
    public bool AllowFineTuning { get; set; }
    public string Organization { get; set; } = "";
    public object? Group { get; set; }
    public bool IsBlocking { get; set; }
}