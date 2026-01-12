# Auto Build + Publish your Godot HTML game to Itch.io with GitHub Actions

*Updated January 2026, using Godot 4.5.1*

![GHActions](https://github.com/user-attachments/assets/46f22a85-47c8-4a4e-b2e6-b320a19ea934)

## Prerequisites
- Your game code is in a GitHub repo
- You already created the project page on itch.io
- ⚠️⚠️⚠️Follow **ALL** the steps below ⚠️⚠️⚠️

## Step 1: itch.io Token
First we need an API Token for itch.io. Head to the `Account Settings > Developer > API Keys` section. This [link](https://itch.io/user/settings/api-keys) should also take you there. Generate a new API key specifically for Github Actions.  

<img width="1264" height="557" alt="022-itch-api-keys" src="https://github.com/user-attachments/assets/36870449-d299-4b9e-a7a1-21462bb38d57" />

## Step 2: GitHub Token
Next up, you will need a dedicated GitHub token. Under your [profile developer settings](https://github.com/settings/tokens) create a new token. Give it the `repo` permissions. Set the expiration date as you see fit.

<img width="1126" height="191" alt="022-github-token" src="https://github.com/user-attachments/assets/6c6cfff6-e821-4c21-a0dd-55a050cf49c6" />

## Step 3: Repository Action Secrets
Go to your game project’s GitHub repo. In the **repository settings** add the following tokens secrets to be accessible in Actions.  Make sure you name them exactly as below:

`GH_TOKEN`
`ITCHIO_TOKEN`

<img width="1166" height="686" alt="022-github-action-secret" src="https://github.com/user-attachments/assets/bb11e805-c11e-4605-a10d-0e9f56ffaed0" />

## Step 4: Create and configure export settings in Godot
If you export your project at least once, Godot will create a `export_presets.cfg` file in the root of the project. You can find the export settings in `Project > Export`.

> [!IMPORTANT]
> Important step.

Give a name to the export template. End the name with `-web`, because it’s a HTML export. 
Alternatively you could do `-windows`, `-macos`, `-linux`, etc. 
This is because the GitHub action we will be using uses this suffix to determine to which [channel](https://itch.io/docs/butler/pushing.html#channel-names) on itch should the build be pushed.

Make sure you setup the export path `exports/web/index.html` as seen on the screen below:

<img width="1838" height="1140" alt="image" src="https://github.com/user-attachments/assets/923d2dcb-69f7-44ac-8be7-2c6f82b69130" />

## Step 5: GitHub Action setup

Add this action to the `.github/workflows` directory in your game's GitHub repository. Create the directory on the repository website or create it locally and then push.

```bash
mkdir -p .github/workflows
touch .github/workflows/itchio-publish.yml
```

Add the following code to the `itchio-publish.yml` file:

```yml
name: Publish to Itch.io

on:
  push:
    branches: ["master"]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout source code
        uses: actions/checkout@v3

      - name: Godot Export
        id: export
        uses: firebelley/godot-export@v7.0.0
        with:
          godot_executable_download_url: https://github.com/godotengine/godot/releases/download/4.5.1-stable/Godot_v4.5.1-stable_linux.x86_64.zip
          godot_export_templates_download_url: https://github.com/godotengine/godot/releases/download/4.5.1-stable/Godot_v4.5.1-stable_export_templates.tpz
          relative_project_path: ./
          archive_output: true
        env:
          GITHUB_TOKEN: ${{secrets.GH_TOKEN}}
      - name: Publish to Itch
        uses: Ayowel/butler-to-itch@v1.2.0
        with:
          butler_key: ${{secrets.ITCHIO_TOKEN}}
          itch_user: antzgames
          itch_game: test-project
          version: ${{ github.ref_name }}
          files: "${{ steps.export.outputs.archive_directory }}/test-web.zip"
```

## Step 6: GitHub Action CONFIG changes

Make the appropiate changes to  `itch_user` and `itch_game` in the `itchio-publish.yml` file:

```yml
          itch_user: replace_with_your_itch_user
          itch_game: replace_with_your_itch_game_name
```

## This repo is a test project

This repository deploys a web test project using the limboAI C++ GDExtension to itch.io at:

https://antzgames.itch.io/test-project?secret=YtwaXmKha1xKVDZSxJCw0HMKOU
