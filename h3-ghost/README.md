# 🚀 Easy Guide: Install Ghost CMS on Infomaniak Node.js Hosting

This guide will help you **install Ghost CMS** (a popular blogging platform) on your **Infomaniak Node.js Hosting**, even if you’ve never used the command line before.

We’ll walk you through every step — no technical knowledge needed!

---

## ✅ What You Need Before Starting

Before installing Ghost, make sure you have these three things ready:

1. **A Node.js Hosting plan from Infomaniak**  
   - 🔗 [Learn more about Infomaniak Node.js Hosting](https://www.infomaniak.com/fr/hebergement/hebergement-nodejs)
   - Requires Node.js 22.x (LTS)

2. **SSH Access enabled**  
   This lets you connect to your server using a terminal.  
   👉 Follow this tutorial to set it up:  
   🔗 [How to enable SSH access](https://faq.infomaniak.com/1982)

3. **A MySQL Database and User**  
   Ghost needs a database to store your blog content.  
   👉 Create one by following this guide:  
   🔗 [Create a database on Infomaniak](https://faq.infomaniak.com/1981)  
   💡 Write down these details:
   - Database name
   - Username
   - Password
   - Host

---

## 📥 Step-by-Step Installation

Stop your Node.JS Application before doing the next steps !

Now that everything is ready, let’s install Ghost!

### 🔗 Step 1: Connect to Your Hosting via SSH

Open your computer's **Terminal** (Mac/Linux) or **Command Prompt/Powershell** (Windows), and type:

```bash
ssh yourusername@your-hosting-domain
```

> Replace:
> - `yourusername` → your Node.js SSH username
> - `your-hosting-domain` → something like `XX-XXXXXX.ssh.hosting-ik.com`

📌 Example:
```bash
ssh john@XX-XXXXXX.ssh.hosting-ik.com
```

- Press **Enter**
- Type **yes** if asked to continue
- Enter your **SSH password** (you won’t see letters as you type — that’s normal!)

You should now see a prompt like this:
```bash
[client@ik-xxx... ~]$
```

✅ You're connected!


### 📄 Step 2: Clone and Run the installation script

Run these commands one by one:

```bash
git clone https://github.com/Infomaniak/hosting-tools.git
cd hosting-tools/h3-ghost
bash ./install.sh
```

💡 The script will now:
- Ask you some questions (like your site URL, database info, etc.)
- Download and set up Ghost automatically
- Take a few minutes — be patient!
Answer the questions carefully using the database details you wrote down earlier.
> 🛑 Don’t close the terminal until it finishes!

### ⚙️ Step 3: Configure Your Hosting (via Infomaniak Panel)

Once the script is done, go to your **Infomaniak Control Panel**:

1. Go to your **Node.js Hosting** dashboard
2. Click on your site → **"Advanced Settings"**
3. Make these changes:
   - 🔲 **Build command**: Disable it
   - 🟢 **Run command**: Paste this exactly:
     ```
     /srv/customer/node_modules/ghost-cli/bin/ghost run
     ```
   - 🔢 **Port**: `3000`
4. Click **Save**
5. Click **Start** (or restart if already running)

---

## 🎉 Done! Access Your Ghost Blog

Open your browser and go to:

👉 **`https://yourwebsite.com/ghost`**

Replace `yourwebsite.com` with your actual domain.

The first time:
- You’ll create an **admin account** (your login for the blog)
- Then you can start writing posts!

---

## ❓ Having Problems?

If something goes wrong:

- Double-check your **database details**
- Make sure the **run command and port** are set correctly
- Wait a few minutes after starting — it can take time to launch

Still stuck?  
👉 [Open an issue on GitHub](https://github.com/Infomaniak/hosting-tools/issues/new) and we’ll help you out!

---

## 🙌 Thanks!

You now have a fully working **Ghost blog** on **Infomaniak** — great job! 🎉  
Perfect for writing, publishing, and growing your audience.
