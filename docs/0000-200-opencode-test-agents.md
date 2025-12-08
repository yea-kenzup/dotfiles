# Date: 2025-12-07
# Changes Made: Added two new opencode subagents (TestRunner and TestCaseWriter)
# Files Modified: home/dot_config/opencode/opencode.jsonc.tmpl
# Benefits: Enhanced testing capabilities with dedicated agents for running tests and writing test cases
# Testing: Verify opencode configuration loads correctly and new agents are available

## TestRunner Subagent
- **Purpose**: Run tests and return results
- **Model**: gpt-oss-120b via Groq
- **Mode**: subagent
- **Use Case**: Execute existing test suites and provide detailed results

## TestCaseWriter Subagent  
- **Purpose**: Write test cases
- **Model**: Gemini 2.5 Flash Lite
- **Mode**: subagent
- **Use Case**: Generate comprehensive test cases for existing code

Both agents are configured as subagents with appropriate models optimized for their respective tasks.