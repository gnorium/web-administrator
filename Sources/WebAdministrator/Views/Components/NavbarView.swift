#if !os(WASI)

import CSSBuilder
import DesignTokens
import HTMLBuilder
import WebTypes

/// Navbar component for administrator pages.
/// Shows the site name, username, and logout link.
public struct NavbarView: HTML {
	let siteName: String
	let username: String

	public init(siteName: String = "Administrator", username: String) {
		self.siteName = siteName
		self.username = username
	}

	public func render(indent: Int = 0) -> String {
		nav {
			div { siteName }
				.style {
					fontFamily(typographyFontSerif)
					fontSize(fontSizeLarge18)
					fontWeight(.normal)
					color(colorBase)
				}

			div {
				span { username }
					.style {
						fontSize(fontSizeSmall14)
						color(colorSubtle)
					}

				a { "Logout" }
					.href("/administrator/logout")
					.style {
						padding(spacing8, spacing16)
						fontFamily(typographyFontSans)
						fontSize(fontSizeSmall14)
						color(colorBase)
						backgroundColor(.transparent)
						border(borderWidthBase, borderStyleBase, borderColorBase)
						borderRadius(borderRadiusBase)
						textDecoration(.none)
						transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
						
						pseudoClass(.hover) {
							backgroundColor(backgroundColorInteractive)
						}
					}
			}
			.style {
				display(.flex)
				gap(spacing16)
				alignItems(.center)
			}
		}
		.class("navbar-view")
		.style {
			backgroundColor(backgroundColorBase)
			borderBottom(borderWidthBase, borderStyleBase, borderColorBase)
			padding(spacing16, spacing24)
			display(.flex)
			justifyContent(.spaceBetween)
			alignItems(.center)
		}
		.render(indent: indent)
	}
}

#endif
