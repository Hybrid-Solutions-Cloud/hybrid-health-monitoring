<script setup lang="ts">
import DefaultTheme from 'vitepress/theme'
import DiagramViewerModal from './DiagramViewerModal.vue'
import { useDiagramViewer } from './useDiagramViewer'
import { onMounted, onUnmounted } from 'vue'

const { Layout } = DefaultTheme
const { open } = useDiagramViewer()

function handleGlobalClick(e: MouseEvent) {
  const target = e.target as HTMLElement
  if (!target) return

  // Check if clicked element is a diagram image inside documentation
  if (target.tagName === 'IMG' && target.closest('.vp-doc')) {
    const img = target as HTMLImageElement
    const src = img.src || ''
    const alt = img.alt || ''

    // Match diagram images (SVG diagrams, assets/diagrams, or descriptive diagram alts)
    if (
      src.includes('/diagrams/') ||
      src.endsWith('.svg') ||
      alt.toLowerCase().includes('diagram') ||
      alt.toLowerCase().includes('architecture') ||
      alt.toLowerCase().includes('model') ||
      alt.toLowerCase().includes('rollup')
    ) {
      e.preventDefault()
      e.stopPropagation()
      open({
        type: 'image',
        content: src,
        title: alt || 'Architecture Diagram'
      })
    }
  }
}

onMounted(() => {
  if (typeof document !== 'undefined') {
    document.addEventListener('click', handleGlobalClick)
  }
})

onUnmounted(() => {
  if (typeof document !== 'undefined') {
    document.removeEventListener('click', handleGlobalClick)
  }
})
</script>

<template>
  <Layout>
    <template #layout-bottom>
      <DiagramViewerModal />
    </template>
  </Layout>
</template>
