// Import child process module to invoke system python commands
const { execSync } = require('child_process');
// Import path helper library
const path = require('path');

// Executes the churn_predictor.py script with features as parameters
function predictChurnProbability(row) {
  try {
    const [recency, redemptionRatio, sipStatus] = row;
    // Resolve absolute path to python script located in the /ml folder
    const scriptPath = path.join(__dirname, '../ml/churn_predictor.py');
    
    // Execute python script synchronously inside its own directory context and capture output
    const output = execSync(`python "${path.basename(scriptPath)}" ${recency} ${redemptionRatio} ${sipStatus}`, {
      cwd: path.dirname(scriptPath),
      encoding: 'utf8',
      timeout: 1000 // Ensure execution terminates within 1 second
    });
    
    // Parse the output probability from python stdout
    return parseFloat(output.trim());
  } catch (err) {
    // Log exception details
    console.error('Python Random Forest execution failed, executing JS heuristic fallback:', err.message);
    
    const [recency, redemptionRatio, sipStatus] = row;
    // Base fallback score
    let fallbackScore = 0.15;
    
    // Evaluate recency feature contribution
    if (recency > 90) fallbackScore += 0.4;
    else if (recency > 60) fallbackScore += 0.3;
    
    // Evaluate redemption ratio feature contribution
    if (redemptionRatio > 0.5) fallbackScore += 0.25;
    else if (redemptionRatio > 0) fallbackScore += 0.15;
    
    // Evaluate SIP status contribution
    if (sipStatus === 3) fallbackScore += 0.35;
    else if (sipStatus === 2) fallbackScore += 0.2;
    else if (sipStatus === 1) fallbackScore += 0.1;
    
    // Return cumulative score capped at 95%
    return Math.min(0.95, fallbackScore);
  }
}

// Export the predictor executor function
module.exports = {
  predictChurnProbability
};
