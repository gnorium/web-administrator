#if !os(WASI)

import CSSBuilder
import DesignTokens
import HTMLBuilder
import WebTypes

/// Login form component for administrator authentication.
/// Use with WebAdministrator.LayoutView for the full page.
public struct LoginView: HTML {
	let errorMessage: String?

	public init(errorMessage: String? = nil) {
		self.errorMessage = errorMessage
	}

	public func render(indent: Int = 0) -> String {
		div {
			div {
				div {
					h1 { "Administrator" }
						.style {
							fontFamily(typographyFontSerif)
							fontSize(px(36))
							fontWeight(.normal)
							color(colorBase)
							marginBottom(spacing8)
							letterSpacing(px(-0.5))
						}

					p { "Sign in to manage content" }
						.style {
                            fontFamily(typographyFontSans)
							fontSize(fontSizeSmall14)
							color(colorSubtle)
							letterSpacing(px(0.2))
						}
				}
				.style {
					textAlign(.center)
					marginBottom(spacing32)
				}

				if let error = errorMessage {
					div { error }
						.style {
							backgroundColor(backgroundColorErrorSubtle)
							color(colorError)
							padding(spacing12, spacing16)
							borderRadius(borderRadiusBase)
							marginBottom(spacing24)
							fontSize(fontSizeSmall14)
						}
				}

				form {
					div {
						label { "Username" }
							.for("username")
							.style {
								display(.block)
								fontFamily(typographyFontSans)
								fontSize(fontSizeSmall14)
								fontWeight(500)
								color(colorBase)
								marginBottom(spacing8)
							}

						input()
							.type(.text)
							.id("username")
							.name("username")
							.required(true)
							.autofocus(true)
							.style {
								width(perc(100))
								padding(spacing12, spacing16)
								fontFamily(typographyFontSans)
								fontSize(fontSizeMedium16)
								color(colorBase)
								backgroundColor(backgroundColorBase)
								border(borderWidthBase, borderStyleBase, borderColorBase)
								borderRadius(borderRadiusBase)
								outline(.none)
								transition(.borderColor, transitionDurationBase, transitionTimingFunctionSystem)
								transition(.boxShadow, transitionDurationBase, transitionTimingFunctionSystem)
								
								pseudoClass(.focus) {
									borderColor(borderColorProgressiveFocus)
									boxShadow(.inset, 0, 0, 0, px(1), borderColorProgressiveFocus)
								}
							}
					}
					.style {
						marginBottom(spacing24)
					}

					div {
						label { "Password" }
							.for("password")
							.style {
								fontFamily(typographyFontSans)
								display(.block)
								fontSize(fontSizeSmall14)
								fontWeight(500)
								color(colorBase)
								marginBottom(spacing8)
							}

						input()
							.type(.password)
							.id("password")
							.name("password")
							.required(true)
							.style {
								width(perc(100))
								padding(spacing12, spacing16)
								fontFamily(typographyFontSans)
								fontSize(fontSizeMedium16)
								color(colorBase)
								backgroundColor(backgroundColorBase)
								border(borderWidthBase, borderStyleBase, borderColorBase)
								borderRadius(borderRadiusBase)
								outline(.none)
								transition(.borderColor, transitionDurationBase, transitionTimingFunctionSystem)
								transition(.boxShadow, transitionDurationBase, transitionTimingFunctionSystem)
								
								pseudoClass(.focus) {
									borderColor(borderColorProgressiveFocus)
									boxShadow(.inset, 0, 0, 0, px(1), borderColorProgressiveFocus)
								}
							}
					}
					.style {
						marginBottom(spacing32)
					}

					button { "Sign In" }
						.type(.submit)
						.style {
							width(perc(100))
							padding(spacing12, spacing24)
							fontFamily(typographyFontSans)
							fontSize(fontSizeMedium16)
							fontWeight(500)
							color(colorInverted)
							backgroundColor(backgroundColorProgressive)
							border(.none)
							borderRadius(borderRadiusBase)
							cursor(.pointer)
							transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
							transition(.boxShadow, transitionDurationBase, transitionTimingFunctionSystem)
							
							pseudoClass(.hover) {
								backgroundColor(backgroundColorProgressiveHover)
							}
							
							pseudoClass(.active) {
								backgroundColor(backgroundColorProgressiveActive)
							}
							
							pseudoClass(.focusVisible) {
								boxShadow(0, 0, 0, px(2), backgroundColorProgressive)
							}
						}
				}
				.action("/administrator/login")
				.method(.post)
			}
			.style {
				width(perc(100))
				maxWidth(px(400))
				backgroundColor(backgroundColorBase)
				border(borderWidthBase, borderStyleBase, borderColorBase)
				borderRadius(borderRadiusSharp)
				boxShadow(boxShadowLarge)
				padding(spacing48)
			}
		}
		.class("login-container")
		.style {
			display(.flex)
			justifyContent(.center)
			alignItems(.center)
			minHeight(vh(100))
			padding(spacing16)
			backgroundColor(backgroundColorNeutralSubtle)
		}
		.render(indent: indent)
	}
}

#endif
