
import FileBuilderKit
import FileBuilderTesting
import XCTest

final class WrapTests: XCTestCase {

    func testNoWrapping() throws {
        try AssertText {
            "One Two Three"
                .wrap(lineLength: 13)
        } is: {
            "One Two Three"
        }
    }

    func testWrapping() throws {
        try AssertText {
            Group {
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
            }
            .wrap(lineLength: 68)
        } is: {
            """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
            pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
            culpa qui officia deserunt mollit anim id est laborum.
            """
        }
    }

    func testWrappingNoSpaces() throws {
        try AssertText {
            Group {
                "Loremipsumdolorsitamet,consecteturadipiscingelit,seddoeiusmodtemporincididuntutlaboreetdoloremagnaaliqua.Utenimadminimveniam,quisnostrudexercitationullamcolaborisnisiutaliquipexeacommodoconsequat.Duisauteiruredolorinreprehenderitinvoluptatevelitessecillumdoloreeufugiatnullapariatur.Excepteursintoccaecatcupidatatnonproident,suntinculpaquiofficiadeseruntmollitanimidestlaborum."
            }
            .wrap(lineLength: 68)
        } is: {
            """
            Loremipsumdolorsitamet,consecteturadipiscingelit,seddoeiusmodtempori
            ncididuntutlaboreetdoloremagnaaliqua.Utenimadminimveniam,quisnostrud
            exercitationullamcolaborisnisiutaliquipexeacommodoconsequat.Duisaute
            iruredolorinreprehenderitinvoluptatevelitessecillumdoloreeufugiatnul
            lapariatur.Excepteursintoccaecatcupidatatnonproident,suntinculpaquio
            fficiadeseruntmollitanimidestlaborum.
            """
        }
    }
}
