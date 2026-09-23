"""Day 2 sample agent — build demonstration starter.

Minimal scaffold: connects to a Foundry project with a managed/default
credential and creates a basic agent with one placeholder tool. Extend this
during the session's build demonstration and guided design activity.
"""
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

# TBD: set to the Day 1 landing-zone Foundry project endpoint
PROJECT_ENDPOINT = "https://<your-foundry-project>.services.ai.azure.com/api/projects/<project-name>"


def create_agent(client: AIProjectClient):
    """Create a minimal agent. Extend with tools/knowledge during the session."""
    agent = client.agents.create_agent(
        model="gpt-4o-mini",  # TBD: confirm supported model for your deployment
        name="day2-sample-agent",
        instructions=(
            "You are a helpful FSI assistant. Answer questions using only the "
            "connected knowledge sources and tools provided to you."
        ),
    )
    return agent


def main():
    credential = DefaultAzureCredential()
    client = AIProjectClient(endpoint=PROJECT_ENDPOINT, credential=credential)
    agent = create_agent(client)
    print(f"Created agent: {agent.id}")


if __name__ == "__main__":
    main()
