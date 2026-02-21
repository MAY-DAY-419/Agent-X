const API_KEY = "AIzaSyAApsz_B_tqq99vWV-5kMl40I3TeYUnP9I";

async function listAvailableModels() {
  console.log("🔍 Listing available Gemini models...\n");
  
  const url = `https://generativelanguage.googleapis.com/v1beta/models?key=${API_KEY}`;
  
  try {
    const response = await fetch(url);
    console.log("Status:", response.status, response.statusText);
    const data = await response.json();
    
    if (data.models) {
      console.log("\n✅ Available models:");
      data.models.forEach(model => {
        console.log(`\n📦 ${model.name}`);
        console.log(`   Display Name: ${model.displayName}`);
        console.log(`   Supports: ${model.supportedGenerationMethods?.join(', ')}`);
      });
    } else {
      console.log("Response:", JSON.stringify(data, null, 2));
    }
  } catch (error) {
    console.error("❌ Error:", error.message);
  }
}

listAvailableModels();
