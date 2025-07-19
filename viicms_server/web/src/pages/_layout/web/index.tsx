import { createFileRoute } from '@tanstack/react-router'
import { Button } from '@mantine/core'

export const Route = createFileRoute('/_layout/web/')({
  component: HomePage,
})

/**
 * 默认首页
 */
function HomePage() {
  return (
    <div className="p-2">
      <h3>Welcome Home!!!</h3>
      <Button variant="filled">Button</Button>
    </div>
  )
}
