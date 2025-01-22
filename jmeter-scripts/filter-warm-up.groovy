// Skip the first 10 requests (warm-up phase)
if (vars.get("samplerName") == null) {
    vars.put("samplerCount", "0");
}

int samplerCount = Integer.parseInt(vars.get("samplerCount"));
samplerCount++;

if (samplerCount > 10) {
    vars.put("samplerName", "Request #" + samplerCount);
    SampleResult.setIgnore(false); // Include in results
} else {
    SampleResult.setIgnore(true);  // Exclude from results
}

vars.put("samplerCount", samplerCount.toString());
