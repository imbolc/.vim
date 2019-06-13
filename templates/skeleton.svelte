<svelte:head>
    <title>Foo</title>
</svelte:head>

{#each items as item}
    {item}<br>
{:else}
    You don't have any items yet
{/each}

<script context="module">
    export async function preload (page, session) {
        try {
            const res = await this.fetch(session.origin + `/api/foo`)
            if (!res.ok) {
                return this.error(res.status, res.statusText)
            }
            const items = await res.json()
            return { items }
        } catch (e) {
            return this.error(503, "Check your network connection")
        }
    }
</script>

<script>
    export let items
</script>
