import { createRootRoute, Outlet } from '@tanstack/react-router'
import { DefaultCatchBoundary } from '~/components/DefaultCatchBoundary'
import { LoadingPlaceholder, NotFound, ThemeManager } from '~/components'
import { TanStackRouterDevtools } from '@tanstack/react-router-devtools'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'

export const Route = createRootRoute({
  component: RootPage,
  errorComponent: DefaultCatchBoundary,
  notFoundComponent: () => <NotFound />,
  pendingComponent: () => <LoadingPlaceholder />,
  ssr: false,
})

/**
 * 根页面
 */
function RootPage() {
  return (
    <>
      {/* 根页面插槽 */}
      <Outlet />
      {/* 主题监听 */}
      <ThemeManager />
      {/* Router和Query开发者工具 */}
      <ReactQueryDevtools buttonPosition="top-right" />
      <TanStackRouterDevtools position="bottom-right" />
    </>
  )
}
