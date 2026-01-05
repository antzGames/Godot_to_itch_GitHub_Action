# Publish your Godot game to Itch.io with GitHub Actions

*Updated January 2026, using Godot 4.5.1*

## Prerequisites
- Your code is in a GitHub repo
- You already created the project page on itch.io

## Step 1: Tokens
First we need an API Token for Itch.io. Head to the `Account Settings > Developer > API Keys` section. This [link](https://itch.io/user/settings/api-keys) should also take you there. Generate a new API key.

> Pic 1

Next up, you will need a dedicated GitHub token. Under your [profile developer settings](https://github.com/settings/tokens) create a new token. Give it the `repo` permissions. Set the expiration date as you see fit.

> Pic 2

Go to your game project’s GitHub repo. In the **repository settings** add the following tokens secrets to be accessible in Actions.

`GH_TOKEN`
`ITCHIO_TOKEN`

> Pic 3

## Step 2: Create export settings in Godot
If you export your project at least once, Godot will create a `export_presets.cfg` file in the root of the project. You can find the export settings in `Project > Export`.

> [!IMPORTANT]
> Important step.

Give a name to the export template. End the name with -web, because it’s a HTML export. 
Alternatively you could do `-windows`, `-macos`, `-linux`, etc. 
This is because the GitHub action we will be using uses this suffix to determine to which [channel](https://itch.io/docs/butler/pushing.html#channel-names) on itch should the build be pushed.
