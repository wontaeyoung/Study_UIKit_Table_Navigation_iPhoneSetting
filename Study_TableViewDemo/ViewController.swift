//
//  ViewController.swift
//  Study_TableViewDemo
//
//  Created by 원태영 on 2022/12/12.
//

import UIKit
import SnapKit
import Then



// 이쁘게 아래에 컨텐츠 채우기
// 네비게이션 구현하기
// 토글에 기능 구현하기




class ViewController: UIViewController {
    
    lazy var tableView = UITableView(frame: .zero,
                                     style: .insetGrouped)

    let data : [[(image : String, content : String)]] = [
        [("person.circle.fill","장다영")],
        [("airplane","에어플레인 모드"),
         ("wifi","Wi-Fi"),
         ("bolt.horizontal","Bluetooth"),
         ("antenna.radiowaves.left.and.right","셀룰러"),
         ("personalhotspot","개인용 핫스팟"),
         ("v.circle","VPN")
        ]
    ]
    
    let header = [
        "프로필",
        "네트워크",
//        "안내",
//        "기본"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setAllConfig()
        setAllSubView()
        setAllConstraints()
        setLayout()
        
    }
    
    private func setAllConfig() {
        self.view.backgroundColor = .white
        tableView.backgroundColor = .systemGray6
        self.tableView.dataSource = self
    }
    
    private func setAllSubView() {
        self.view.addSubview(self.tableView)
    }
    
    private func setAllConstraints() {
        
        tableView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}

// 테이블 데이터 관리 익스텐션
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toggleList = ["에어플레인 모드","VPN"]
        let detailTextList = ["Bluetooth","개인용 핫스팟"]
        
        let cell = UITableViewCell(style: .value1,
                                   reuseIdentifier: .none)
        var someContent = UIListContentConfiguration.subtitleCell()
        
        let someData = data[indexPath.section][indexPath.row]
        let switchButton = UISwitch(frame: .zero)
        
        cell.textLabel?.text = someData.content
        cell.imageView?.image = UIImage(systemName: someData.image)
        
        /* 이거 컬렉션뷰에서 쓸 수 있는거라고 되어있어서 적용해봤는데 안됨
        if someData.content == "장다영" {
            someContent.secondaryText = "회고 3조의 파치리스"
        }
         */
        
        if toggleList.contains(someData.content) {
            cell.accessoryView = switchButton
        } else {
            cell.accessoryType = .disclosureIndicator
            if detailTextList.contains(someData.content) {
                cell.detailTextLabel?.text = "끔"
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
}



extension ViewController {
    func setLayout() {
        
        title = "설정"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}





// 프리뷰 생성
// Storyboard 파일과 프로젝트 세팅에서 main 이름을 사용하는 모든 설정도 삭제해야 함
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

@available(iOS 14.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
